//
//  FlowChargeRequest.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "FlowChargeRequest.h"
#import "WBPortsFile.h"
#import "XMNetworking.h"
#import "VTGeneralTool.h"
#import <SVProgressHUD.h>

static FlowChargeRequest* flow = nil;
@implementation FlowChargeRequest

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flow = [[FlowChargeRequest alloc] init];
    });
    return flow;
}

-(void)flowChargeWithPhoneNum:(NSString *)phoneNum orderId:(NSString *)pid type:(RechargeType)type sucess:(SucessBlock)sucess{
    //校验值，md5(OpenID+key+phone+pid+orderid)，结果转为小写
    NSString* sign = [NSString new];
    switch (type) {
        case 1:
            sign = [NSString stringWithFormat:@"%@%@%@%@%@",PhoneCharge_OpenID,PhoneRecharge_key,phoneNum,pid,[VTGeneralTool getDateWithType:@"YYYYMMdd"]];
            break;
        case 2:
            sign = [NSString stringWithFormat:@"%@%@%@%@%@",PhoneCharge_OpenID,PhoneFlowCharge_Key,phoneNum,pid,[VTGeneralTool getDateWithType:@"YYYYMMdd"]];
            break;
        default:
            break;
    }
    sign = [[VTGeneralTool md5:sign] lowercaseString];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = PhoneFlowCharge_Url;
        request.parameters = @{@"phone":phoneNum,
                               @"pid":pid,
                               @"orderid":[VTGeneralTool getDateWithType:@"YYYYMMdd"],
                               @"key":PhoneFlowCharge_Key,
                               @"sign":sign};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"reason"]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        sucess(responseObject[@"result"]);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

@end
