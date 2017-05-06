//
//  UIImage+clipsImage.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (clipsImage)
/**
 * 按尺寸裁剪图片
 */
-(UIImage*)clipImageWithScaleWithSize:(CGSize)size;

@end
