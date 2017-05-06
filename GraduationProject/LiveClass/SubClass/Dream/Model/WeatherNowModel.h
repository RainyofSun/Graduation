//
//  WeatherNowModel.h
//  GraduationProject
//
//  Created by MS on 17/3/15.
//  Copyright © 2017年 LR. All rights reserved.
//实时的天气model类

#import "WBBaseModel.h"

@interface WeatherNowModel : WBBaseModel

/**当前温度*/
@property(nonatomic,copy)NSString* temp;
/**当前湿度*/
@property(nonatomic,copy)NSString* humidity;
/**当前风力*/
@property(nonatomic,copy)NSString* wind_strength;
/**当前风向*/
@property(nonatomic,copy)NSString* wind_direction;

@end
