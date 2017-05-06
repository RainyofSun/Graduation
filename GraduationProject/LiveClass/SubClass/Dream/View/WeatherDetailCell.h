//
//  WeatherDetailCell.h
//  GraduationProject
//
//  Created by MS on 17/3/17.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableViewCell.h"
#import "WeatherFutureModel.h"

@interface WeatherDetailCell : WBTableViewCell

//未来几天天气的模型
@property(nonatomic,strong)WeatherFutureModel* futureModel;

@end
