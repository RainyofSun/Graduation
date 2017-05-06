//
//  GDMapClass.h
//  GraduationProject
//
//  Created by MS on 17/4/8.
//  Copyright © 2017年 LR. All rights reserved.
//高德地图类

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface GDMapClass : NSObject

+(instancetype)shareMap;
/**地图类*/
@property(nonatomic,strong)MAMapView* mapView;

@end
