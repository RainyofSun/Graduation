//
//  ExpressSearchRequest.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "ExpressSearchRequest.h"
#import "WBPortsFile.h"
#import "XMNetworking.h"
#import "ExpressModel.h"
#import <SVProgressHUD.h>

static ExpressSearchRequest* express = nil;
@implementation ExpressSearchRequest

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        express = [[ExpressSearchRequest alloc] init];
    });
    return express;
}

-(void)expressSearchWithNum:(NSString *)num companyName:(NSString *)company sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = ExpressSearch_Url;
        request.parameters = @{@"number":num,
                               @"type":@"auto",
                               @"appkey":ExpressSearch_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"status"] intValue] == 205) {
            [SVProgressHUD showWithStatus:@"暂无信息"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:2];
            return;
        }
        NSMutableArray* status = [NSMutableArray array];
        NSMutableArray* time = [NSMutableArray array];
        for (NSDictionary* dict in responseObject[@"result"][@"list"]) {
            ExpressModel* model = [ExpressModel modelWithDictionary:dict];
            [status addObject:model.status];
            [time addObject:model.time];
        }
        sucess(status,time,@{@"status":responseObject[@"result"][@"deliverystatus"],@"number":responseObject[@"result"][@"number"]});
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

@end
