//
//  NSObject+AddProperty.h
//  BXYJWB
//
//  Created by MS on 17/1/17.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AddProperty)

/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
@property (nonatomic,strong) NSString *stringProperty;
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
@property (nonatomic,assign) NSInteger integerProperty;

@end
