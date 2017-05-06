//
//  WBLocationManager.h
//  GraduationProject
//
//  Created by MS on 17/3/15.
//  Copyright © 2017年 LR. All rights reserved.
//定位管理类

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol WBLocationManagerDelegate <NSObject>

/**
 * 获取定位的位置
 */
-(void)getTheLocation:(CLLocation*)location;

@end

@interface WBLocationManager : NSObject

+(instancetype)shareInstance;

@property(nonatomic,weak)id<WBLocationManagerDelegate>delegate;
/**
 * 开始定位
 */
-(void)startLocation;
/**
 * 结束定位
 */
-(void)endLocation;
/**
 * 根据定位获得城市名字
 */
-(NSString*)getCityNameFromLocation:(CLLocation*)location;
/**
 * 根据地名获得经纬度
 */
-(NSDictionary*)getLocationFormCityName:(NSString*)cityName;

@end
