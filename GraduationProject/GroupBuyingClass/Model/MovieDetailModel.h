//
//  MovieDetailModel.h
//  GraduationProject
//
//  Created by MS on 17/3/28.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"
#import "MovieHallModel.h"

@interface MovieDetailModel : WBBaseModel

//电影ID
@property(nonatomic,copy)NSString* movieId;
//电影名字
@property(nonatomic,copy)NSString* movieName;
//电影图片
@property(nonatomic,copy)NSString* pic_url;
//大厅列表
@property(nonatomic,strong)NSMutableArray* broadcast;

@end
