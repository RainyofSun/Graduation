//
//  GroupBuyingReqeust.h
//  GraduationProject
//
//  Created by MS on 17/3/22.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SucessBlock)(NSMutableArray* dataSource);
typedef void (^HotelDetailBlock)(NSDictionary* dict);
typedef void (^MovieDetailBlock)(NSMutableArray* movie,NSMutableArray* hall);
@interface GroupBuyingReqeust : NSObject

+(instancetype)shareInstance;

/**
 * 根据地理位置获取美食
 */
-(void)groupBuyingSearchWithLon:(NSString*)lon lat:(NSString*)lat sucess:(SucessBlock)sucess;
/**
 * 根据城市名搜索美食
 */
-(void)groupBuyingSearchWithCityName:(NSString*)cityName page:(NSString*)page sucess:(SucessBlock)sucess;
/**
 * 酒店模块-->获取城市列表
 */
-(void)getCityListSucess:(SucessBlock)sucess;
/**
 * 酒店模块-->获取酒店列表根据城市ID
 */
-(void)getHotelListWithCityId:(NSString*)cityId page:(NSString*)page sucess:(SucessBlock)sucess;
/**
 * 获取酒店详情
 */
-(void)getHotelDetailMessage:(NSString*)hotelID sucess:(HotelDetailBlock)sucess;
/**
 * 查询景点列表
 */
-(void)getScenicAreaList:(NSString*)cityid page:(NSString*)page sucess:(SucessBlock)sucess;
/**
 * 获取景点详情
 */
-(void)getScenicAreaDetail:(NSString*)scenicId sucess:(SucessBlock)sucess;
/**
 * 获取电影列表
 */
-(void)getMovieCityListSucess:(SucessBlock)sucess;
/**
 * 根据城市ID进行影院的搜索
 */
-(void)getMovieSearchWithCityId:(NSString*)cityId page:(NSString*)page sucess:(SucessBlock)sucess;
/**
 * 根据影院ID获取影片信息
 */
-(void)getMovieDetailMsg:(NSString*)movieId sucess:(SucessBlock)sucess;

@end
