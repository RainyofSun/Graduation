//
//  TVShowListCell.h
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableViewCell.h"
#import "TvShowListModel.h"

@interface TVShowListCell : WBTableViewCell

//数据模型
@property(nonatomic,strong)TvShowListModel* modelSource;

@end
