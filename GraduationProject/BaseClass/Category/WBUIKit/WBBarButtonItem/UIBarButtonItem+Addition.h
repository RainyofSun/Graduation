//
//  UIBarButtonItem+Addition.h
//  BXYJWB
//
//  Created by MS on 17/1/13.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Addition)

/**
 * 快速创建一个UIBarButtonItem对象 通过给定的图片
 */
+(instancetype)itemWithImage:(NSString*)imageName hightImageName:(NSString*)heightImageName target:(id)target action:(SEL)action;

/**
 * 快速创建一个UIBarButtonItem对象 通过给定的图片
 */
+(instancetype)itemWithImage:(NSString *)imageName hightImageName:(NSString *)heightImageName touchBlock:(void(^)())block;

/**
 * 快速创建一个UIBarButtonItem对象 通过给定的标题和tintColor
 */
+(instancetype)itemWithTitle:(NSString *)title tintColor:(UIColor*)tintColor touchBlock:(void(^)())block;

/**
 * 快速创建一个UIBarButtonItem对象 通过给定的标题和tintColor
 */
+(instancetype)itemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor target:(id)target action:(SEL)action;


@end
