//
//  ExpressSearchRequest.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SucessBlock)(NSMutableArray* status,NSMutableArray* time,NSDictionary* dict);
@interface ExpressSearchRequest : NSObject

+(instancetype)shareInstance;

/**
 * 查询快递
 */
-(void)expressSearchWithNum:(NSString*)num companyName:(NSString*)company sucess:(SucessBlock)sucess;

@end
