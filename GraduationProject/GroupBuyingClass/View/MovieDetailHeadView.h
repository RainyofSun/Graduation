//
//  MovieDetailHeadView.h
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableHeaderFooterView.h"
#import "MovieDetailModel.h"
#import <YYText.h>

@interface MovieDetailHeadView : WBTableHeaderFooterView

@property(nonatomic,strong)MovieDetailModel* detailDataSource;
//影院电话
@property(nonatomic,strong)UILabel* moviePhone;
//影院地址
@property(nonatomic,strong)UILabel* address;
//影院交通
@property(nonatomic,strong)YYLabel* movieTransport;
//影院名称
@property(nonatomic,strong)UILabel* movieTitle;

@end
