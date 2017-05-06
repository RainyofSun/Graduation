//
//  LifeCollectionModel.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "LifeCollectionModel.h"

@implementation LifeCollectionModel

+(instancetype)loadDataWithDict:(NSDictionary *)dict{
    return [[LifeCollectionModel alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.imageName = dict[@"image"];
        self.title = dict[@"title"];
    }
    return self;
}

@end
