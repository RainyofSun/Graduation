//
//  UINavigationBar+Addition.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Addition)
/**
 * 通过运行时设置背景颜色
 */
-(void)wb_setBackgroundColor:(UIColor*)backgroundColor;
/**
 * 设置导航栏上元素的透明度
 */
-(void)setElementAlpha:(CGFloat)alpha;
/**
 * 设置导航栏的偏移量
 */
-(void)setTranslationY:(CGFloat)translationY;
/**
 * 恢复默认设置
 */
-(void)reset;
/**
 * 隐藏导航栏下面的分割线
 */
-(void)hideNavigationBarBottomLineView;
/**
 * 显示导航栏下面的分割线
 */
-(void)showNavigationBarBottomLineView;
@end
