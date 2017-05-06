//
//  UILabel+Addition.m
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

-(instancetype)initWithFont:(CGFloat)font
                  textColor:(UIColor *)textColor
              textAlignment:(NSTextAlignment)textAlignment{
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:font];
        self.textAlignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
        self.textColor = textColor;
    }
    return self;
}

+(instancetype)labelWithFont:(CGFloat)font
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment{
    return [[UILabel alloc] initWithFont:font textColor:textColor textAlignment:textAlignment];
}

@end
