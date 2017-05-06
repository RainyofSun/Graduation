//
//  UILabel+countDown.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (countDown)

/**
 * 倒计时按钮
 * @param timeLine 倒计时总时间
 * @param title    还没倒计时的title
 * @param subTitle 倒计时的子名字:时,分
 * @param mColor   还没倒计时的颜色
 * @param color    倒计时的颜色
 */
-(void)startWithTime:(NSInteger)timeLine title:(NSString*)title countDownTitle:(NSString*)subTitle mainColor:(UIColor*)mColor countColor:(UIColor*)color;

-(void)stopTime;
@end
