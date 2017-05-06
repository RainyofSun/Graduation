//
//  WeatherRequest.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WeatherRequest.h"
#import "WBPortsFile.h"
#import "XMNetworking.h"
#import "WeatherTodayModel.h"
#import "WeatherNowModel.h"
#import "WeatherFutureModel.h"
#import <SVProgressHUD.h>

static WeatherRequest* weather = nil;
@implementation WeatherRequest

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weather = [[WeatherRequest alloc] init];
    });
    return weather;
}

-(void)weatherQueryWithLon:(NSString*)lon lat:(NSString*)lat sucess:(SucessBlock)sucess{
    if (!lon || !lat) {
        [SVProgressHUD showErrorWithStatus:@"坐标不正确,请更正"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        return;
    }
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = Weather_Url;
        request.parameters = @{@"lon":lon,
                               @"lat":lat,
                               @"format":@2,
                               @"key":Weather_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] == 203905) {
            [SVProgressHUD showErrorWithStatus:@"坐标不正确,请更正"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        if ([responseObject[@"error_code"] intValue] == 203907) {
            [SVProgressHUD showErrorWithStatus:@"查询不到该IP地址相关的天气信息"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        if ([responseObject[@"error_code"] intValue] == 203902) {
            [SVProgressHUD showErrorWithStatus:@"查询不到该城市的信息"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:@"查询不到该城市的信息"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        NSMutableDictionary* today = [[NSMutableDictionary alloc] init];
        [today addEntriesFromDictionary:responseObject[@"result"][@"today"]];
        NSMutableDictionary* now = [[NSMutableDictionary alloc] init];
        [now addEntriesFromDictionary:responseObject[@"result"][@"sk"]];
        NSMutableArray* future = [NSMutableArray array];
        for (NSDictionary* dict in responseObject[@"result"][@"future"]) {
            WeatherFutureModel* futureModel = [WeatherFutureModel modelWithDictionary:dict];
            [future addObject:futureModel];
        }
        sucess(today,now,future);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

@end
