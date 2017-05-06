//
//  CurrencyCell.h
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableViewCell.h"
#import "OilQueryModel.h"

@interface CurrencyCell : WBTableViewCell

//数据模型
@property(nonatomic,strong)OilQueryModel* modelSource;

@end
