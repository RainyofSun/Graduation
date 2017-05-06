//
//  MovieDetailCell.h
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableViewCell.h"
#import "MovieDetailModel.h"

@protocol MovieDetailCellDelegate <NSObject>

//跳转买票
-(void)ticketsShow:(NSString*)sender;

@end

@interface MovieDetailCell : WBTableViewCell

@property(nonatomic,weak)id<MovieDetailCellDelegate>delegate;

@property(nonatomic,strong)MovieDetailModel* dataSource;

@end
