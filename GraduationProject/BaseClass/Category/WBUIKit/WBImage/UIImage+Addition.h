//
//  UIImage+Addition.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface UIImage (Addition)

/**
 * 圆形头像
 * @param name        头像图片名称
 * @param borderWidth 外边框宽度
 * @param borderColor 边框颜色
 */
+(UIImage*)circleImageWithName:(NSString*)name
                   borderWidth:(CGFloat)borderWidth
                   borderColor:(UIColor*)borderColor;
/**
 * 保持宽高比设置图片在多大区域显示
 * @param sourceImage 图片名称
 * @param targetSize  目标大小
 */
-(UIImage*)sourceImage:(UIImage*)sourceImage
            targetSize:(CGSize)targetSize;

/**
 * 指定宽度按比例缩放
 * @param sourceImage 图片名称
 * @param targetWidth 指定宽度
 */
-(UIImage*)sourceImage:(UIImage*)sourceImage
           targetWidth:(CGFloat)targetWidth;
/**
 * 等比例缩放
 * @param sourceImage 图片名称
 * @param scale       缩放倍数
 */
-(UIImage*)sourceImage:(UIImage*)sourceImage
                 scale:(CGFloat)scale;
+(UIImage*)resizableImageWithImagename:(NSString*)imageName;

/**
 * 压缩图片到指定的物理大小
 */
-(NSData*)compressImageDataWithMaxLimit:(CGFloat)maxLimit;
-(UIImage*)compressImageWithMaxLimit:(CGFloat)maxLimit;
/**
 * 将图片保存到相册
 */
- (void)loadImageFinished;
@end
