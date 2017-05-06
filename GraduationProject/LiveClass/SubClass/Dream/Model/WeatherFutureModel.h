//
//  WeatherFutureModel.h
//  GraduationProject
//
//  Created by MS on 17/3/15.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"
#import "WeatherModelTotal.h"

@interface WeatherFutureModel : WBBaseModel

/**时间*/
@property(nonatomic,copy)NSString* date;
/**温度*/
@property(nonatomic,copy)NSString* temperature;
/**天气*/
@property(nonatomic,copy)NSString* weather;
/**星期*/
@property(nonatomic,copy)NSString* week;
/**风向*/
@property(nonatomic,copy)NSString* wind;
/**天气标示模型*/
@property(nonatomic,strong)WeatherModelTotal* weather_id;

@end
