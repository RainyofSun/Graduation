//
//  WeatherTodayModel.h
//  GraduationProject
//
//  Created by MS on 17/3/15.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"
#import "WeatherModelTotal.h"

@interface WeatherTodayModel : WBBaseModel

/**城市*/
@property(nonatomic,copy)NSString* city;
/**日期*/
@property(nonatomic,copy)NSString* date_y;
/**根据天气给出的建议*/
@property(nonatomic,copy)NSString* dressing_advice;
/**穿衣指数*/
@property(nonatomic,copy)NSString* dressing_index;
/**运动指数*/
@property(nonatomic,copy)NSString* exercise_index;
/**气温*/
@property(nonatomic,copy)NSString* temperature;
/**旅游指数*/
@property(nonatomic,copy)NSString* travel_index;
/**紫外线指数*/
@property(nonatomic,copy)NSString* uv_index;
/**洗车指数*/
@property(nonatomic,copy)NSString* wash_index;
/**天气*/
@property(nonatomic,copy)NSString* weather;
/**星期*/
@property(nonatomic,copy)NSString* week;
/**风力*/
@property(nonatomic,copy)NSString* wind;
@property(nonatomic,strong)WeatherModelTotal* weather_id;

@end
