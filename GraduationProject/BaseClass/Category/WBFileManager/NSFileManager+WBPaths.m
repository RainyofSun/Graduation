//
//  NSFileManager+WBPaths.m
//  BXYJWB
//
//  Created by MS on 17/1/13.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "NSFileManager+WBPaths.h"
#include <sys/xattr.h>

@implementation NSFileManager (WBPaths)
+ (NSURL *)URLForDirectory:(NSSearchPathDirectory)directory {
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)pathForDirectory:(NSSearchPathDirectory)directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)documentsURL {
    return [self URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)documentsPath {
    return [self pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)libraryURL {
    return [self URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)libraryPath {
    return [self pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)cachesURL {
    return [self URLForDirectory:NSCachesDirectory];
}

+ (NSString *)cachesPath {
    return [self pathForDirectory:NSCachesDirectory];
}

+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path {
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)availableDiskSpace {
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.documentsPath error:nil];
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

@end
