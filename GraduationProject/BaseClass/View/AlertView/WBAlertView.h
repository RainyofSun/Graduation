//
//  WBAlertView.h
//  BXYJWB
//
//  Created by MS on 17/2/7.
//  Copyright © 2017年 yxkjios. All rights reserved.
/*
 定制弹出视图
 */

#import <UIKit/UIKit.h>
//点击按钮回调
typedef void(^AlertResult)(NSInteger index);

@interface WBAlertView : UIView
@property(nonatomic,copy) AlertResult resultIndex;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

-(void)showMKPAlertView;
@end
