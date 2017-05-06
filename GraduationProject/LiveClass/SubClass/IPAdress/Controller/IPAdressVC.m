//
//  IPAdressVC.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "IPAdressVC.h"
#import "WBIntroduceFile.h"
#import "AirQueryRequest.h"
#import "AirSearchView.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"

@interface IPAdressVC ()<AirSearchViewDelegate>

@property(nonatomic,strong)AirSearchView* airView;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@end

@implementation IPAdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"空气质量";
    [self airView];
}

#pragma mark - AirSearchViewDelegate
-(void)startSeartAirData:(NSString *)cityName{
    WS(weakSelf);
    if ([[cityName transform] containsString:@" "]) {
        cityName = [[cityName transform] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }else{
        cityName = [cityName transform];
    }
    [[AirQueryRequest shareInstance] getCityAir:cityName sucess:^(NSDictionary *citynow) {
        [weakSelf performOnMainThread:^{
            [weakSelf.airView.cityNameSearch setText:AppendString(@"城  市:%@", citynow[@"city"])];
            [weakSelf.airView.time setText:AppendString(@"查询时间:%@", citynow[@"date"])];
            [weakSelf.airView.AQI setText:AppendString(@"AQI指数:%@", citynow[@"AQI"])];
            [weakSelf.airView.quality setText:AppendString(@"空气质量:%@", citynow[@"quality"])];
        } wait:NO];
    }];
}
// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    WBAlertView* alert = [[WBAlertView alloc] initWithTitle:@"温馨提示" message:@"请打开定位开关" sureBtn:@"确定" cancleBtn:@"取消"];
    [alert showMKPAlertView];
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    WBAlertView* alert = [[WBAlertView alloc] initWithTitle:@"温馨提示" message:@"定位失败,请重试" sureBtn:@"确定" cancleBtn:@"取消"];
    [alert showMKPAlertView];
}

-(void)searchMoreCity:(id)sender{
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    WS(weakSelf);
    [cityViewController choseCityBlock:^(NSString *cityName) {
        [weakSelf.airView.cityName setText:cityName];
        cityName = [cityName substringWithRange:NSMakeRange(0, cityName.length - 1)];
        [weakSelf startSeartAirData:cityName];
    }];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentVc:navigationController];
}

#pragma mark - 懒加载
-(AirSearchView *)airView{
    if (!_airView) {
        _airView = [[AirSearchView alloc] init];
        _airView.delegate = self;
        [self.view addSubview:_airView];
        [_airView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.trailing.bottom.equalTo(self.view);
        }];
    }
    return _airView;
}

- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
