//
//  NewsCell.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableViewCell.h"
#import "NewsModel.h"

@interface NewsCell : WBTableViewCell

//数据源
@property(nonatomic,strong)NewsModel* modelSource;

@end