//
//  UIView+Layer.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

/**
 * 快速设置圆角
 * @param cornerRadius 弧度
 * @param borderWidth 边宽
 * @param borderColor 边的颜色
 */
-(void)setLayerConrnerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor*)borderColor;
/**
 * 快速设置分割线
 */
-(void)setViewSeparateLine:(CGRect)frame color:(UIColor*)color;

/**
 * 边角半径
 */
@property(nonatomic,assign)CGFloat layerCornerRadius;
/**
 * 边线宽度
 */
@property(nonatomic,assign)CGFloat layerBorderWidth;
/**
 * 边线颜色
 */
@property(nonatomic,assign)UIColor* layerBorderColor;

@end
