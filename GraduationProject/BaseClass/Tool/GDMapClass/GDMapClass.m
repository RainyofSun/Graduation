//
//  GDMapClass.m
//  GraduationProject
//
//  Created by MS on 17/4/8.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "GDMapClass.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "POIAnnotation.h"

static GDMapClass* mapClass = nil;

@interface GDMapClass ()



@end

@implementation GDMapClass

+(instancetype)shareMap{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapClass = [[GDMapClass alloc] init];
        mapClass.mapView = [[MAMapView alloc] init];
        ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
        [AMapServices sharedServices].enableHTTPS = YES;
        
    });
    return mapClass;
}



@end
