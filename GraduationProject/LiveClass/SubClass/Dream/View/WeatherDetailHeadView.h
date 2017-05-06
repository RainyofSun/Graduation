//
//  WeatherDetailHeadView.h
//  GraduationProject
//
//  Created by MS on 17/3/16.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableHeaderFooterView.h"
#import "WeatherTodayModel.h"

@interface WeatherDetailHeadView : WBTableHeaderFooterView

@property(nonatomic,strong)WeatherTodayModel* dataSource;

@end
