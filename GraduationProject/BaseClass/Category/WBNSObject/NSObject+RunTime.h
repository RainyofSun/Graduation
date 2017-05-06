//
//  NSObject+RunTime.h
//  BXYJWB
//
//  Created by MS on 17/1/17.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RunTime)

/**
 * 动态替换方法
 */
+(void)swizzleMethod:(SEL)originaMethod withMethod:(SEL)newMethod;
/**
 * 动态为某个类添加方法
 */
+(void)appendMethod:(SEL)newMethod fromClass:(Class)wbClass;
/**
 * 动态为某个类替换方法
 */
+(void)replaceMethod:(SEL)method fromClass:(Class)wbClass;
/**
 Check whether the receiver implements or inherits a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)respondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)superRespondsToSelector:(SEL)selector;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether the receiver's instances implement or inherit a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
+ (BOOL)instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;

@end
