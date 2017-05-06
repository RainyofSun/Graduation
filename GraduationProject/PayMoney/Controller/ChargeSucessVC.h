//
//  ChargeSucessVC.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "BaseVC.h"

@interface ChargeSucessVC : BaseVC

//充值套餐
@property(nonatomic,copy)NSString* cardname;
//聚合订单号
@property(nonatomic,copy)NSString* JHOrderID;
//自己定义的订单号
@property(nonatomic,copy)NSString* CustomOrderID;

@end
