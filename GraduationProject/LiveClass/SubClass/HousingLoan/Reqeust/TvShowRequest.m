//
//  TvShowRequest.m
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "TvShowRequest.h"
#import "WBPortsFile.h"
#import "XMNetworking.h"
#import "TVChannelModel.h"
#import "TvShowListModel.h"
#import "TvCategoryModel.h"
#import <SVProgressHUD.h>

static TvShowRequest* TvReqeust = nil;
@implementation TvShowRequest

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TvReqeust = [[TvShowRequest alloc] init];
    });
    return TvReqeust;
}

-(void)getTvShowCategorySucess:(CategoryBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = TVCategory_Url;
        request.parameters = @{@"key":TVShow_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        NSMutableArray* title = [NSMutableArray array];
        NSMutableArray* idSource = [NSMutableArray array];
        for (NSDictionary* dict in responseObject[@"result"]) {
            TvCategoryModel* model = [TvCategoryModel modelWithDictionary:dict];
            [title addObject:model.name];
            [idSource addObject:model.id];
        }
        sucess(title,idSource);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)TvShowChannelListSearch:(NSString *)pId sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = TVShowChannel_Url;
        request.parameters = @{@"pId":pId,@"key":TVShow_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        NSMutableArray* data = [NSMutableArray array];
        for (NSDictionary* dict in responseObject[@"result"]) {
            TVChannelModel* model = [TVChannelModel modelWithDictionary:dict];
            [data addObject:model];
        }
        sucess(data);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)TvShowList:(NSString *)code sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = TVShowList_Url;
        request.parameters = @{@"code":code,@"key":TVShow_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"result"] isKindOfClass:[NSNull class]] || responseObject[@"result"] == nil) {
            [SVProgressHUD showErrorWithStatus:@"暂无数据"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return ;
        }
        NSMutableArray* data = [NSMutableArray array];
        for (NSDictionary* dict in responseObject[@"result"]) {
            TvShowListModel* model = [TvShowListModel modelWithDictionary:dict];
            [data addObject:model];
        }
        sucess(data);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

@end
