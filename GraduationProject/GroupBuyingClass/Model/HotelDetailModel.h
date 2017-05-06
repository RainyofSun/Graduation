//
//  HotelDetailModel.h
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface HotelDetailModel : WBBaseModel

//酒店介绍
@property(nonatomic,copy)NSString* intro;
//酒店基础信息
@property(nonatomic,copy)NSString* basic;
//酒店服务
@property(nonatomic,copy)NSString* serve;
//房间设施
@property(nonatomic,copy)NSString* roomFacility;
//入住条件
@property(nonatomic,copy)NSString* policy;
//酒店设施
@property(nonatomic,copy)NSString* hotelFacilities;
//餐厅设施
@property(nonatomic,copy)NSString* foodfunf;
//酒店环境
@property(nonatomic,copy)NSString* entertainment;

@end
