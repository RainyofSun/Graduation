//
//  UIView+Layer.m
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)

-(void)setLayerConrnerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

-(void)setLayerBorderColor:(UIColor *)layerBorderColor{
    self.layer.borderColor = layerBorderColor.CGColor;
    [self _config];
}

-(UIColor *)layerBorderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(void)setLayerBorderWidth:(CGFloat)layerBorderWidth{
    self.layer.borderWidth = layerBorderWidth;
    [self _config];
}

-(CGFloat)layerBorderWidth{
    return self.layer.borderWidth;
}

-(void)setLayerCornerRadius:(CGFloat)layerCornerRadius{
    self.layer.cornerRadius = layerCornerRadius;
    [self _config];
}

-(CGFloat)layerCornerRadius{
    return self.layer.cornerRadius;
}

-(void)_config{
    self.layer.masksToBounds = YES;
    //栅格化 － 提高性能
    //设置栅格化后，涂层会被渲染成图片，并且缓存,在此使用时，不会再次渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

-(void)setViewSeparateLine:(CGRect)frame color:(UIColor *)color{
    CAShapeLayer* layer = [CAShapeLayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

@end
