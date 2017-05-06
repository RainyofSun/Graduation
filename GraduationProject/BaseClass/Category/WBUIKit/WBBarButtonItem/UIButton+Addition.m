//
//  UIButton+Addition.m
//  BXYJWB
//
//  Created by MS on 17/1/13.
//  Copyright © 2017年 yxkjios. All rights reserved.
/*
 运行时关联策略
 OBJC_ASSOCIATION_ASSIGN  等价属性@property(assign) or @property(unsafe_unretained) 弱引用关联对象
 OBJC_ASSOCIATION_RETAIN_NONATOMIC 等价属性@property(strong,nonatomic) 强引用关联对象且非原子操作
 OBJC_ASSOCIATION_COPY_NONATOMIC  等价属性@property(copy,nonatomic) 复制关联对象,且为非原子操作
 OBJC_ASSOCIATION_RETAIN  等价属性@property(strong,nonatomic) 强引用关联对象,且为原子操作
 OBJC_ASSOCIATION_COPY    等价属性@property(copy,nonatomic) 复制关联对象,且为原子操作
 */
#import "UIButton+Addition.h"
#import <objc/runtime.h>

typedef void (^ActionBlock)();
@implementation UIButton (Addition)
static char buttonBlockKey;

-(ActionBlock)block{
    /*
     获取相关联的对象
     断开关联是使用objc_setAssociatedObject函数，传入nil值即可
     */
    return objc_getAssociatedObject(self, &buttonBlockKey);
}

-(void)setBlock:(ActionBlock)block{
    /*把一个对象与另外一个对象进行关联。该函数需要四个参数：源对象，关键字，关联的对象和一个关联策略
     ■  关键字是一个void类型的指针。每一个关联的关键字必须是唯一的。通常都是会采用静态变量来作为关键字。
     ■  关联策略表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；还有这种关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。这种关联策略是通过使用预先定义好的常量来表示的
     */
    objc_setAssociatedObject(self, &buttonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+(instancetype)buttonWithImagename:(NSString *)imagename
                    hightImagename:(NSString *)hightImagename
                       bgImagename:(NSString *)bgImagename
                            target:(id)target
                            action:(SEL)action{
    UIButton* button = [[UIButton alloc] init];
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (imagename) {
        [button setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    }
    if (hightImagename) {
        [button setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    }
    //竖直方向的对齐方式
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    return button;
}

+(instancetype)buttonWithImagename:(NSString *)imagename
                    hightImagename:(NSString *)hightImagename
                       bgImagename:(NSString *)bgImagename
                        touchBlock:(void (^)())block{
    UIButton* button = [self buttonWithImagename:imagename hightImagename:hightImagename bgImagename:bgImagename target:self action:@selector(btnTouch:)];
    button.block = block;
    return button;
}

+(void)btnTouch:(UIButton*)button{
    if (button.block) {
        button.block();
    }
}

+(instancetype)buttonWithTitle:(NSString *)title
                   normalColor:(UIColor *)normalColor
                 selectedColor:(UIColor *)selectedColor
                      fontSize:(CGFloat)fontSize
                    touchBlock:(void (^)())block{
    UIButton* button = [self buttonWithTitle:title
                                 normalColor:normalColor
                               selectedColor:selectedColor
                                    fontSize:fontSize
                                      target:selectedColor
                                      action:@selector(btnTouch:)];
    button.block = block;
    return button;
}

+(instancetype)buttonWithTitle:(NSString *)title
                   normalColor:(UIColor *)normalColor
                   diableColor:(UIColor *)diableColor
                      fontSize:(CGFloat)fontSize
                        target:(id)target
                        action:(SEL)action{
    UIButton* button = [[UIButton alloc] init];
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor && title) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (diableColor && title) {
        [button setTitleColor:diableColor forState:UIControlStateDisabled];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    return button;
}

+(instancetype)buttonWithTitle:(NSString *)title
                   normalColor:(UIColor *)normalColor
                 selectedColor:(UIColor *)selectedColor
                      fontSize:(CGFloat)fontSize
                        target:(id)target
                        action:(SEL)action{
    UIButton* button = [[UIButton alloc] init];
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor && title) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor && title) {
        [button setTitleColor:selectedColor forState:UIControlStateNormal];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    return button;
}
@end
