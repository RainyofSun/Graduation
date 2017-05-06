//
//  IDCardReqeust.m
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "IDCardReqeust.h"
#import "XMNetworking.h"
#import "WBPortsFile.h"

static IDCardReqeust* request = nil;
@implementation IDCardReqeust

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[IDCardReqeust alloc] init];
    });
    return request;
}

-(NSDictionary *)searchIdCardNum:(NSString *)IdNum sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = IDCard_Search;
        request.parameters = @{@"key":IDCard_KEY,@"cardno":IdNum};
        request.headers = @{@"User-Agent": @"Custom User Agent"};
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        sucess(responseObject[@"result"]);
    } onFailure:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    return nil;
}

@end
