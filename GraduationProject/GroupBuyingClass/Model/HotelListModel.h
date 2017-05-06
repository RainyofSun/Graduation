//
//  HotelListModel.h
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface HotelListModel : WBBaseModel

//酒店ID
@property(nonatomic,copy)NSString* id;
//酒店名字
@property(nonatomic,copy)NSString* name;
//星级
@property(nonatomic,copy)NSString* className;
//酒店简介
@property(nonatomic,copy)NSString* intro;
//
@property(nonatomic,copy)NSString* dpNum;
//坐标
@property(nonatomic,copy)NSString* Lat;
@property(nonatomic,copy)NSString* Lon;
//地址
@property(nonatomic,copy)NSString* address;
//酒店图片
@property(nonatomic,copy)NSString* largePic;
//酒店详情
@property(nonatomic,copy)NSString* url;
//满意度
@property(nonatomic,copy)NSString* manyidu;

@end
