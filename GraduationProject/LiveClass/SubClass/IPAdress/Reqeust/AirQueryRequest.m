//
//  AirQueryRequest.m
//  GraduationProject
//
//  Created by MS on 17/3/17.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "AirQueryRequest.h"
#import "WBPortsFile.h"
#import "XMNetworking.h"
#import <SVProgressHUD.h>

static AirQueryRequest* air = nil;
@implementation AirQueryRequest

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        air = [[AirQueryRequest alloc] init];
    });
    return air;
}

-(void)getCityAir:(NSString *)cityName sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = AirQuery_Url;
        request.parameters = @{@"key":AirQuery_Key,@"city":cityName};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] == 203301) {
            [SVProgressHUD showErrorWithStatus:@"输入的城市有误,请更正"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        if ([responseObject[@"error_code"] intValue] == 203302) {
            [SVProgressHUD showErrorWithStatus:@"此城市不存在结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        sucess([[responseObject[@"result"] objectAtIndex:0] objectForKey:@"citynow"]);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

@end
