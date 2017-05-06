//
//  NSString+GetDate.m
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "NSString+GetDate.h"

@implementation NSString (GetDate)

- (NSString *)transform{
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

@end
