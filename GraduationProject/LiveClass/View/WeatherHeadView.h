//
//  WeatherHeadView.h
//  GraduationProject
//
//  Created by MS on 17/3/15.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableHeaderFooterView.h"
#import "WeatherTodayModel.h"

@protocol WeatherHeadViewDelegate <NSObject>

//跳转到天气详情
-(void)weatherDetail:(id)sender;

@end

@interface WeatherHeadView : WBTableHeaderFooterView

@property(nonatomic,weak)id<WeatherHeadViewDelegate>delegate;
/**数据源*/
@property(nonatomic,strong)WeatherTodayModel* dataSource;
//城市名字
@property(nonatomic,strong)UILabel* cityName;

@end
