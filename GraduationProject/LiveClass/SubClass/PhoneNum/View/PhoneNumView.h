//
//  PhoneNumView.h
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneNumViewDelegate <NSObject>

//点击搜索按钮
-(void)searchThePhoneNum:(NSString*)phoneNum;

@end

@interface PhoneNumView : UIView

@property(nonatomic,weak)id<PhoneNumViewDelegate> delegate;
//号码归属地
@property(nonatomic,strong)UILabel* numAddress;
//运营卡类型
@property(nonatomic,strong)UILabel* cardType;
//区号
@property(nonatomic,strong)UILabel* areaNum;
//城市
@property(nonatomic,strong)UILabel* city;
//邮编
@property(nonatomic,strong)UILabel* zipCode;

@end
