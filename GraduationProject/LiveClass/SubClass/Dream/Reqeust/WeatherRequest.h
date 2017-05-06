//
//  WeatherRequest.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SucessBlock)(NSDictionary* today,NSDictionary* now,NSMutableArray* future);
@interface WeatherRequest : NSObject

+(instancetype)shareInstance;

/**
 * 根据GPS查询天气状况
 */
-(void)weatherQueryWithLon:(NSString*)lon lat:(NSString*)lat sucess:(SucessBlock)sucess;

@end
