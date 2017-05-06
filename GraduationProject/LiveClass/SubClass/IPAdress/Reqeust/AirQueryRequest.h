//
//  AirQueryRequest.h
//  GraduationProject
//
//  Created by MS on 17/3/17.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SucessBlock)(NSDictionary* citynow);
@interface AirQueryRequest : NSObject

+(instancetype)shareInstance;

/**
 * 获取城市的空气质量
 */
-(void)getCityAir:(NSString*)cityName sucess:(SucessBlock)sucess;

@end
