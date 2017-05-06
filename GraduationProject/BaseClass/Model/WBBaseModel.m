//
//  WBBaseModel.m
//  BXYJWB
//
//  Created by MS on 17/1/13.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "WBBaseModel.h"
#import <MJExtension.h>
#import "WBFileCache.h"

@implementation WBBaseModel

+(NSMutableArray*)modelArrayWithDictArray:(NSArray*)response{
    if ([response isKindOfClass:[NSArray class]]) {
        NSMutableArray* array = [self mj_objectArrayWithKeyValuesArray:response];
        return array;
    }
    return [NSMutableArray new];
}

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:dictionary];
    }
    return [[self alloc] init];
}

+(void)setUpModelClassInArrayWithCotainDict:(NSDictionary *)dict{
    if (dict.allKeys.count == 0) {
        return;
    }
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return dict;
    }];
}

+(NSMutableArray *)modelArrayWithDictArray:(NSArray *)response containDict:(NSDictionary *)dict{
    if (dict == nil) {
        dict = [NSMutableDictionary new];
    }
    [self setUpModelClassInArrayWithCotainDict:dict];
    return [self modelArrayWithDictArray:response];
}

+ (id)modelWithDictionary:(NSDictionary *)dictionary containDict:(NSDictionary *)dict {
    if (dict == nil) {
        dict = [NSMutableDictionary new];
    }
    [self setUpModelClassInArrayWithCotainDict:dict];
    return [self modelWithDictionary:dictionary];
}

-(void)archive{
    [WBFileCache saveObject:self byFileName:[self.class description]];
}

-(void)unarchiver{
    [WBFileCache getObjectByFileName:[self.class description]];
}

-(void)remove{
    [WBFileCache removeObjectByFileName:[self.class description]];
}
@end
