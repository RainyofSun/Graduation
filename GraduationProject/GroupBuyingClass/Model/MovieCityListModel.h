//
//  MovieCityListModel.h
//  GraduationProject
//
//  Created by MS on 17/3/28.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface MovieCityListModel : WBBaseModel

//城市ID
@property(nonatomic,copy)NSString* id;
//城市名字
@property(nonatomic,copy)NSString* city_name;
//城市拼音
@property(nonatomic,copy)NSString* city_pinyin;


@end
