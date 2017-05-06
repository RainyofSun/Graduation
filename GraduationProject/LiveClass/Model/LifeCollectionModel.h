//
//  LifeCollectionModel.h
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LifeCollectionModel : NSObject

//图片名字
@property(nonatomic,copy)NSString* imageName;
//图片下边的标题
@property(nonatomic,copy)NSString* title;

+(instancetype)loadDataWithDict:(NSDictionary*)dict;
-(instancetype)initWithDict:(NSDictionary*)dict;

@end
