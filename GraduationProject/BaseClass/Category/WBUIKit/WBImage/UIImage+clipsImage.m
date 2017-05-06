//
//  UIImage+clipsImage.m
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "UIImage+clipsImage.h"

@implementation UIImage (clipsImage)

-(UIImage *)clipImageWithScaleWithSize:(CGSize)size{
    UIImage* newImage;
    UIImage* image = self;
    if (nil == image) {
        newImage = nil;
    }else{
        CGSize oldSize = image.size;
        CGRect rect;
        if (size.width / size.height > oldSize.width / oldSize.height) {
            rect.size.width = size.width;
            rect.size.height = size.width * oldSize.height / oldSize.width;
            rect.origin.x = 0;
            rect.origin.y = (size.height - rect.size.height) / 2;
        }else{
            rect.size.width = size.height*oldSize.width / oldSize.height;
            rect.size.height = size.height;
            rect.origin.x = (size.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToRect(context, CGRectMake(0, 0, size.width, size.height));
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        [image drawInRect:rect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
}

@end
