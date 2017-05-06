//
//  UIView+Tap.m
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "UIView+Tap.h"
#import <objc/runtime.h>

static const char * actionHanderTapGestureKey;
@implementation UIView (Tap)
/**
 * 动态添加手势
 */
-(void)setTapActionWithBlock:(void (^)(void))block{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = objc_getAssociatedObject(self, &actionHanderTapGestureKey);
    if (!tap) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:tap];
        objc_setAssociatedObject(self, &actionHanderTapGestureKey, tap, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &actionHanderTapGestureKey, block, OBJC_ASSOCIATION_COPY);
}

-(void)handleActionForTapGesture:(UITapGestureRecognizer*)sender{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(sender, &actionHanderTapGestureKey);
        if (action) {
            action();
        }
    }
}

/**
 * 快速添加手势
 */
-(void)setTapTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

/**
 * 快速添加长按手势
 */
-(void)setLongTapGesture:(id)target action:(SEL)action{
    UILongPressGestureRecognizer* lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    lpgr.minimumPressDuration = 1.0;
    [self addGestureRecognizer:lpgr];
}
@end
