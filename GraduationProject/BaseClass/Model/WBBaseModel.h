//
//  WBBaseModel.h
//  BXYJWB
//
//  Created by MS on 17/1/13.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBaseModel : NSObject

/**
 * 归档 － 存入模型
 */
-(void)archive;
/**
 * 解档 － 取出模型
 */
-(void)unarchiver;
/**
 * 移除缓存中的模型
 */
-(void)remove;
/**
 * 字典数组转模型数组
 */
+(NSMutableArray*)modelArrayWithDictArray:(NSArray*)response;
/**
 * 字典转模型
 */
+(instancetype)modelWithDictionary:(NSDictionary*)dictionary;
/**
 * 模型包含模型数组
 */
+(void)setUpModelClassInArrayWithCotainDict:(NSDictionary*)dict;
/**
 * 字典数组转模型数组
 * @param dict 模型包含模型数组 格式为key－字段名字 value - [被包含的类名]
 */
+(NSMutableArray*)modelArrayWithDictArray:(NSArray*)response containDict:(NSDictionary*)dict;

@end
