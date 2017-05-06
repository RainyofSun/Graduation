//
//  WBLocationManager.m
//  GraduationProject
//
//  Created by MS on 17/3/15.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBLocationManager.h"
#import <SVProgressHUD.h>
#import "NSObject+GCD.h"
#import "WBConfig.h"

static WBLocationManager* location = nil;

@interface WBLocationManager ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager* locationManager;

@end

@implementation WBLocationManager

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[WBLocationManager alloc] init];
        [location locationManager];//初始化定位
        [location startLocationMyPosition];//获取定位授权
    });
    return location;
}

-(void)startLocation{
    //开始定位，不断调用其代理方法
    [location.locationManager startUpdatingLocation];
}

-(void)endLocation{
    //停止定位
    [location.locationManager stopUpdatingHeading];
}

#pragma mark - 反向地理位置解析
-(NSString*)getCityNameFromLocation:(CLLocation*)location{
    __block NSString* cityName = [NSString new];
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            NSLog(@"定位错误");
            return ;
        }
        CLPlacemark* placePark = [placemarks objectAtIndex:0];
        cityName = placePark.locality;
    }];
    return cityName;
}

#pragma mark - 根据城市名字得到位置坐标
-(NSDictionary *)getLocationFormCityName:(NSString *)cityName{
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    __block NSString* lon = [NSString new];
    __block NSString* lat = [NSString new];
    [geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if ([placemarks count] > 0 && error == nil) {
            CLPlacemark* placePark = [placemarks objectAtIndex:0];
            lon = [NSString stringWithFormat:@"%f",placePark.location.coordinate.longitude];
            lat = [NSString stringWithFormat:@"%f",placePark.location.coordinate.latitude];
        }else if ([placemarks count] == 0 && error == nil){
            [SVProgressHUD showErrorWithStatus:@"没有找到坐标"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }else if (error != nil){
            NSLog(@"%@",error);
        }
        
    }];
    return @{@"lon":lon,@"lat":lat};
}
#pragma mark - 开始定位
-(void)startLocationMyPosition{
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //获取用户位置的对象
    CLLocation* location = [locations firstObject];
//    CLLocationCoordinate2D coordinate = location.coordinate;
    if ([self.delegate respondsToSelector:@selector(getTheLocation:)]) {
        [self.delegate getTheLocation:location];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error.code == kCLErrorDenied) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"便民信息需要您开启定位设置" delegate:self cancelButtonTitle:@"再想想" otherButtonTitles:@"现在就去", nil];
        [alert show];
    }
}

#pragma mark - 懒加载
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;//定位的精确度,精确度越高越耗流量和耗电
        _locationManager.distanceFilter = 10;
    }
    return _locationManager;
}

@end
