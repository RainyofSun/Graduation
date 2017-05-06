//
//  NewsRequest.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "NewsRequest.h"
#import "WBPortsFile.h"
#import "XMNetworking.h"
#import "NewsModel.h"

static NewsRequest* news = nil;
@implementation NewsRequest

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        news = [[NewsRequest alloc] init];
    });
    return news;
}

-(void)getNewsDataWithType:(NSString *)type sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = News_Url;
        request.parameters = @{@"type":type,
                               @"key":News_key};
    } onSuccess:^(id  _Nullable responseObject) {
        NSMutableArray* dataSource = [NSMutableArray array];
        for (NSDictionary* dict in responseObject[@"result"][@"data"]) {
            NewsModel* model = [NewsModel modelWithDictionary:dict];
            [dataSource addObject:model];
        }
        sucess(dataSource);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

@end
