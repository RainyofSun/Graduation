//
//  TvShowRequest.h
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SucessBlock)(NSMutableArray* dataSource);
typedef void (^CategoryBlock)(NSMutableArray* title,NSMutableArray* idArray);
@interface TvShowRequest : NSObject

+(instancetype)shareInstance;
/**
 * @brief 获取节目分类
 */
-(void)getTvShowCategorySucess:(CategoryBlock)sucess;
/**
 * @brief 请求电视节目频道列表
 * @param pId Strng
 */
-(void)TvShowChannelListSearch:(NSString*)pId sucess:(SucessBlock)sucess;
/**
 * @brief获取电视节目列表
 * @param code String 频道代码
 */
-(void)TvShowList:(NSString*)code sucess:(SucessBlock)sucess;

@end
