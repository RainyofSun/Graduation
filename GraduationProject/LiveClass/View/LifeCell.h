//
//  LifeCell.h
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableViewCell.h"
#import "LifeTableModel.h"

@protocol LifeCellDelegate <NSObject>

//点击cell进行跳转
-(void)pushDetailVC:(NSString*)title;

@end

@interface LifeCell : WBTableViewCell

@property(nonatomic,weak)id<LifeCellDelegate> delegate;
//设置数据
-(void)setData:(NSArray*)array;

@end
