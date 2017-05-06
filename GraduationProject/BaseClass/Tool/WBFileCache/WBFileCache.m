//
//  WBFileCache.m
//  BXYJWB
//
//  Created by MS on 17/1/13.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "WBFileCache.h"
#import "NSFileManager+WBPaths.h"
#import "WBConfig.h"

@implementation WBFileCache

//对象归档到沙盒
+(BOOL)saveObject:(id)object byFileName:(NSString *)fileName{
    NSString* path = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    BOOL sucess = [NSKeyedArchiver archiveRootObject:object toFile:path];
    return sucess;
}

//通过文件名从沙盒中找到归档的对象
+(id)getObjectByFileName:(NSString *)fileName{
    NSString* path = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return obj;
}

//根据文件名删除沙盒中的文件
+(void)removeObjectByFileName:(NSString *)fileName{
    NSString* path = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+(NSString*)appendFilename:(NSString*)fileName{
    //沙盒路径
    NSString* cachesPath = [NSFileManager cachesPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachesPath isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachesPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return cachesPath;;
}

//拼接文件路径
+(NSString*)appendFilePath:(NSString*)fileName{
    //沙盒路径
    NSString* cachesPath = [NSFileManager cachesPath];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@",cachesPath,fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileName isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return filePath;
}

#pragma mark - user default
//存储用户偏好设置
+(void)saveUserData:(id)data forKey:(NSString *)key{
    [WBUSERDEFAULT setObject:data forKey:key];
    [WBUSERDEFAULT synchronize];
}

//读取用户的偏好设置
+(id)readUserDataForKey:(NSString *)key{
    id obj = [WBUSERDEFAULT objectForKey:key];
    [WBUSERDEFAULT synchronize];
    return obj;
}

//删除用户的偏好设置
+(void)removeUserDataForKey:(NSString *)key{
    [WBUSERDEFAULT removeObjectForKey:key];
    [WBUSERDEFAULT synchronize];
}

@end
