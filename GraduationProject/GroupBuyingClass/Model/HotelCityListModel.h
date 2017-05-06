//
//  HotelCityListModel.h
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface HotelCityListModel : WBBaseModel

//城市ID
@property(nonatomic,copy)NSString* cityId;
//城市名字
@property(nonatomic,copy)NSString* cityName;
//省份ID
@property(nonatomic,copy)NSString* provinceId;

@end
