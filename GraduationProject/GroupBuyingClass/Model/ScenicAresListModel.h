//
//  ScenicAresListModel.h
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface ScenicAresListModel : WBBaseModel

//景点名字
@property(nonatomic,copy)NSString* title;
//景点等级
@property(nonatomic,copy)NSString* grade;
//最低门票
@property(nonatomic,copy)NSString* price_min;
//评价次数
@property(nonatomic,copy)NSString* comm_cnt;
//地址
@property(nonatomic,copy)NSString* address;
//id
@property(nonatomic,copy)NSString* sid;
//订票地址
@property(nonatomic,copy)NSString* url;
//图片
@property(nonatomic,copy)NSString* imgurl;

@end
