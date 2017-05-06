//
//  UILabel+Addition.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

-(instancetype)initWithFont:(CGFloat)font
                  textColor:(UIColor*)textColor
              textAlignment:(NSTextAlignment)textAlignment;

+(instancetype)labelWithFont:(CGFloat)font
                  textColor:(UIColor*)textColor
              textAlignment:(NSTextAlignment)textAlignment;

@end
