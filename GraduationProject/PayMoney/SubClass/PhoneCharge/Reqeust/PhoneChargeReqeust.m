//
//  PhoneChargeReqeust.m
//  GraduationProject
//
//  Created by MS on 17/3/13.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "PhoneChargeReqeust.h"
#import "XMNetworking.h"
#import "WBPortsFile.h"
#import "VTGeneralTool.h"
#import <SVProgressHUD.h>

static PhoneChargeReqeust* phone = nil;
@implementation PhoneChargeReqeust

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        phone = [[PhoneChargeReqeust alloc] init];
    });
    return phone;
}

-(void)checkThePhoneNum:(NSString *)phoneNum money:(NSString *)money sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = PhoneNumTest_Url;
        request.parameters = @{@"phoneno":phoneNum,@"cardnum":money,@"key":PhoneRecharge_key};
    } onSuccess:^(id  _Nullable responseObject) {
        sucess(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)searchTheProduct:(NSString *)phoneNum money:(NSString *)money sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = SearchProduct_Url;
        request.parameters = @{@"phoneno":phoneNum,@"cardnum":money,@"key":PhoneRecharge_key};
    } onSuccess:^(id  _Nullable responseObject) {
        sucess(responseObject[@"result"]);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)phoneFeeQuickCharge:(NSString *)phoneNum money:(NSString *)money type:(PhoneRechargetype)type sucess:(SucessBlock)sucess{
//    sign	string	是	校验值，md5(OpenID+key+phoneno+cardnum+orderid)
    NSString* sign = [NSString stringWithFormat:@"%@%@%@%@%@",PhoneCharge_OpenID,PhoneRecharge_key,phoneNum,money,[VTGeneralTool getDateWithType:@"YYYYMMdd"]];
    sign = [[VTGeneralTool md5:sign] lowercaseString];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = PhoneChargeFee_Url;
        request.parameters = @{@"phoneno":phoneNum,
                               @"cardnum":money,
                               @"orderid":[VTGeneralTool getDateWithType:@"YYYYMMdd"],
                               @"key":PhoneRecharge_key,
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
