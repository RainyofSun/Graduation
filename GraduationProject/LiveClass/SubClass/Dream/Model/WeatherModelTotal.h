//
//  WeatherModelTotal.h
//  GraduationProject
//
//  Created by MS on 17/3/15.
//  Copyright © 2017年 LR. All rights reserved.
//天气标示

#import "WBBaseModel.h"

@interface WeatherModelTotal : WBBaseModel

/**天气唯一标识*/
@property(nonatomic,copy)NSString* weather_id;
/**天气标识00：晴*/
@property(nonatomic,copy)NSString* fa;
/**天气标识53：霾 如果fa不等于fb，说明是组合天气*/
@property(nonatomic,copy)NSString* fb;

@end
