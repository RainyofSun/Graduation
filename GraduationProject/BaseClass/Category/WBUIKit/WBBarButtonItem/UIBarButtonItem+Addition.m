//
//  UIBarButtonItem+Addition.m
//  BXYJWB
//
//  Created by MS on 17/1/13.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "UIBarButtonItem+Addition.h"
#import <objc/runtime.h>

static char btnBlockKey;
static char itemBlockKey;
typedef void (^ActionBlock)();

@implementation UIBarButtonItem (Addition)
static char btnBlockKey;

+(instancetype)itemWithImage:(NSString *)imageName hightImageName:(NSString *)heightImageName target:(id)target action:(SEL)action{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (heightImageName) {
        [button setImage:[UIImage imageNamed:heightImageName] forState:UIControlStateHighlighted];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.frame = (CGRect){CGPointZero,button.currentImage.size};
    return [[self alloc] initWithCustomView:button];
}

+(instancetype)itemWithImage:(NSString *)imageName hightImageName:(NSString *)heightImageName touchBlock:(void (^)())block{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] init];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (heightImageName) {
        [button setImage:[UIImage imageNamed:heightImageName] forState:UIControlStateHighlighted];
    }
    [button addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(button, &btnBlockKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    button.frame = (CGRect){CGPointZero,button.currentImage.size};
    [item setCustomView:button];
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor target:(id)target action:(SEL)action{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    item.tintColor = tintColor;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor touchBlock:(void (^)())block{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(itemTouch:)];
    item.tintColor = tintColor;
    item.block = block;
    return item;
}

+(void)itemTouch:(UIBarButtonItem*)item{
    if (item.block) {
        item.block();
    }
}

-(void)setBlock:(ActionBlock)block{
    objc_setAssociatedObject(self, &itemBlockKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ActionBlock)block{
    return objc_getAssociatedObject(self, &itemBlockKey);
}

-(void)btnTouch:(UIButton*)btn{
    ActionBlock block = objc_getAssociatedObject(btn, &btnBlockKey);
    if (block) {
        block();
    }
}

@end
