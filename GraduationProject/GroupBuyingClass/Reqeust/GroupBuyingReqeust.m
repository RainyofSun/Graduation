//
//  GroupBuyingReqeust.m
//  GraduationProject
//
//  Created by MS on 17/3/22.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "GroupBuyingReqeust.h"
#import "WBPortsFile.h"
#import "XMNetworking.h"
#import <SVProgressHUD.h>
#import "GroupBuyingModel.h"
#import "HotelCityListModel.h"
#import "HotelListModel.h"
#import "ScenicAresListModel.h"
#import "ScenicAreaDetailModel.h"
#import "MovieCityListModel.h"
#import "MovieListModel.h"
#import "MovieDetailModel.h"
#import "MovieHallModel.h"

static GroupBuyingReqeust* group = nil;
@implementation GroupBuyingReqeust

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        group = [[GroupBuyingReqeust alloc] init];
    });
    return group;
}

-(void)groupBuyingSearchWithLon:(NSString *)lon lat:(NSString *)lat sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = GroupBuyingLocationSearch_Url;
        request.parameters = @{@"lng":lon,
                               @"lat":lat,
                               @"key":GroupBuying_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 200) {
            [SVProgressHUD showErrorWithStatus:@"暂无结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        NSMutableArray* dataSource = [NSMutableArray array];
        dataSource = [GroupBuyingModel modelArrayWithDictArray:responseObject[@"result"]];
        sucess(dataSource);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)groupBuyingSearchWithCityName:(NSString *)cityName page:(NSString *)page sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = GroupBuyingCitySearch_Url;
        request.parameters = @{@"city":cityName,
                               @"page":page,
                               @"key":GroupBuying_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:@"暂无结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return;
        }
        NSMutableArray* dataSource = [NSMutableArray array];
        dataSource = [GroupBuyingModel modelArrayWithDictArray:responseObject[@"result"]];
        sucess(dataSource);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)getCityListSucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = Hotel_GetCity_List_Url;
        request.parameters = @{@"key":Hotel_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:@"暂无结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return ;
        }
        NSMutableArray* dataSource = [NSMutableArray array];
        dataSource = [HotelCityListModel modelArrayWithDictArray:responseObject[@"result"]];
        sucess(dataSource);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)getHotelListWithCityId:(NSString *)cityId page:(NSString*)page sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = Hotel_Url;
        request.parameters = @{@"key":Hotel_Key,
                               @"cityid":cityId,
                               @"page":page};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:@"暂无结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return ;
        }
        NSMutableArray* data = [NSMutableArray array];
        data = [HotelListModel modelArrayWithDictArray:responseObject[@"result"]];
        sucess(data);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)getHotelDetailMessage:(NSString *)hotelID sucess:(HotelDetailBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = HotelDetail_Url;
        request.parameters = @{@"key":Hotel_Key,
                               @"hid":hotelID};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:@"暂无结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return ;
        }
        sucess(responseObject[@"result"]);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)getScenicAreaList:(NSString *)cityid page:(NSString *)page sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = SceniaArea_Url;
        request.parameters = @{@"key":Hotel_Key,
                               @"cid":cityid,
                               @"page":page};
    } onSuccess:^(id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"reason"]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return ;
        }
        NSMutableArray* data = [NSMutableArray array];
        data = [ScenicAresListModel modelArrayWithDictArray:responseObject[@"result"]];
        sucess(data);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)getScenicAreaDetail:(NSString *)scenicId sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = ScenicAreaDetail_Url;
        request.parameters = @{@"key":Hotel_Key,
                               @"sid":scenicId};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:@"暂无结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return ;
        }
        NSMutableArray* data = [NSMutableArray array];
        data = [ScenicAreaDetailModel modelArrayWithDictArray:responseObject[@"result"]];
        sucess(data);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)getMovieCityListSucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = Movie_Search_City_Url;
        request.parameters = @{@"key":Movie_Key};
    } onSuccess:^(id  _Nullable responseObject) {
        NSMutableArray* dataSource = [NSMutableArray array];
        dataSource = [MovieCityListModel modelArrayWithDictArray:responseObject[@"result"]];
        sucess(dataSource);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)getMovieSearchWithCityId:(NSString *)cityId page:(NSString *)page sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = Movie_Search_Url;
        request.parameters = @{@"key":Movie_Key,
                               @"page":page,
                               @"cityid":cityId};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:@"暂无结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return ;
        }
        NSMutableArray* dataSource = [NSMutableArray array];
        dataSource = [MovieListModel modelArrayWithDictArray:responseObject[@"result"][@"data"]];
        sucess(dataSource);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

-(void)getMovieDetailMsg:(NSString *)movieId sucess:(SucessBlock)sucess{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = Movie_Detail_Url;
        request.parameters = @{@"key":Movie_Key,
                               @"cinemaid":movieId};
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] != 0) {
            [SVProgressHUD showErrorWithStatus:@"暂无结果"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            return ;
        }
        NSMutableArray* dataSource = [NSMutableArray array];
        dataSource = [MovieDetailModel modelArrayWithDictArray:responseObject[@"result"][@"lists"]];
        sucess(dataSource);
    } onFailure:^(NSError * _Nullable error) {
        if (error) NSLogError;
    }];
}

@end
