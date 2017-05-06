//
//  MovieHallModel.h
//  GraduationProject
//
//  Created by MS on 17/3/28.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface MovieHallModel : WBBaseModel

//电影播放大厅
@property(nonatomic,copy)NSString* hall;
//影票价格
@property(nonatomic,copy)NSString* price;
//订票网址
@property(nonatomic,copy)NSString* ticket_url;
//开演时间
@property(nonatomic,copy)NSString* time;

@end
