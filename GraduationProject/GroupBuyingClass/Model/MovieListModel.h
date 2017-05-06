//
//  MovieListModel.h
//  GraduationProject
//
//  Created by MS on 17/3/28.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface MovieListModel : WBBaseModel

//电影院ID
@property(nonatomic,copy)NSString* id;
//影院名称
@property(nonatomic,copy)NSString* cinemaName;
//影院地址
@property(nonatomic,copy)NSString* address;
//影院电话
@property(nonatomic,copy)NSString* telephone;
//影院位置
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
//交通线
@property(nonatomic,copy)NSString* trafficRoutes;

@end
