//
//  PhoneNumRequest.m
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "PhoneNumRequest.h"
#import "XMNetworking.h"
#import "WBPortsFile.h"

static PhoneNumRequest* phone = nil;
@implementation PhoneNumRequest

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        phone = [[PhoneNumRequest alloc] init];
    });
    return  phone;
}

-(void)searchThePhoneNum:(NSString *)phoneNum sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = PhoneNum_Search;
        request.parameters = @{@"phone":phoneNum,@"key":PhoneNum_Key};
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        sucess(responseObject[@"result"]);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLog(@"%@",error.localizedDescription);
    }];
}

@end
