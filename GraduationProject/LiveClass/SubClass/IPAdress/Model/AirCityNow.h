//
//  AirCityNow.h
//  GraduationProject
//
//  Created by MS on 17/3/17.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface AirCityNow : WBBaseModel

//AQI指数
@property(nonatomic,copy)NSString* AQI;
//城市名字
@property(nonatomic,copy)NSString* city;
//时间
@property(nonatomic,copy)NSString* date;
//空气质量
@property(nonatomic,copy)NSString* quality;

@end
