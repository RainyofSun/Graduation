//
//  AirSearchView.h
//  GraduationProject
//
//  Created by MS on 17/3/17.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirSearchViewDelegate <NSObject>

/**开始搜索空气质量*/
-(void)startSeartAirData:(NSString*)cityName;
/**更多城市*/
-(void)searchMoreCity:(id)sender;

@end

@interface AirSearchView : UIView

@property(nonatomic,weak)id<AirSearchViewDelegate>delegate;
//AQI
@property(nonatomic,strong)UILabel* AQI;
//城市名字
@property(nonatomic,strong)UILabel* cityNameSearch;
//查询时间
@property(nonatomic,strong)UILabel* time;
//空气质量
@property(nonatomic,strong)UILabel* quality;
//输入城市的名字
@property(nonatomic,strong)UITextField* cityName;

@end
