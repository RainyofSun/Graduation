//
//  WBFileCache.h
//  BXYJWB
//
//  Created by MS on 17/1/13.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBFileCache : NSObject
/**
 * 把对象归档存到沙盒licache路径下
 */
+(BOOL)saveObject:(id)object byFileName:(NSString*)fileName;
/**
 * 通过文件名从沙盒中找到归档对象
 */
+(id)getObjectByFileName:(NSString*)fileName;
/**
 * 根据文件名删除沙盒中的归档对象
 */
+(void)removeObjectByFileName:(NSString*)fileName;
/**
 * 存储用户偏好位置到userdefaults
 */
+(void)saveUserData:(id)data forKey:(NSString*)key;
/**
 * 读取用户的偏好设置
 */
+(id)readUserDataForKey:(NSString*)key;
/**
 * 删除用户的偏好设置
 */
+(void)removeUserDataForKey:(NSString*)key;
@end
