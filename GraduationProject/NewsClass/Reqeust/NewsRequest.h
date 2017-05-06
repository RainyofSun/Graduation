//
//  NewsRequest.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SucessBlock)(NSMutableArray* dataSource);
@interface NewsRequest : NSObject

+(instancetype)shareInstance;

/**
 * 请求新闻头条
 */
-(void)getNewsDataWithType:(NSString*) type sucess:(SucessBlock)sucess;
@end
