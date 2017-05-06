//
//  UIView+Tap.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)
/**
 * 动态添加手势
 */
-(void)setTapActionWithBlock:(void(^)(void))block;
/**
 * 快速添加view的点击手势
 */
-(void)setTapTarget:(id)target action:(SEL)action;
/**
 * 快速添加view的长按手势
 */
-(void)setLongTapGesture:(id)target action:(SEL)action;

@end
