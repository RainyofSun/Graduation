//
//  CurrencyReqeust.m
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "CurrencyReqeust.h"
#import "WBPortsFile.h"
#import "XMNetworking.h"
#import "OilQueryModel.h"

static CurrencyReqeust* currency = nil;
@implementation CurrencyReqeust

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currency = [[CurrencyReqeust alloc] init];
    });
    return currency;
}

-(void)oilPriceQuerySucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = Oil_Query;
        request.parameters = @{@"key":OIL_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        NSMutableArray* data = [NSMutableArray array];
        NSString* update = responseObject[@"time"];
        for (NSDictionary* dict in responseObject[@"result"]) {
            OilQueryModel* model = [OilQueryModel modelWithDictionary:dict];
            [data addObject:model];
        }
        sucess(data,update);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

@end
