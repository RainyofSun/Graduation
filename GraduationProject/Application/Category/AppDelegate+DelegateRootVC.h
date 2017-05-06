//
//  AppDelegate+DelegateRootVC.h
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (DelegateRootVC)

/**
 * 首次启动轮播图
 */
-(void)createLoadingScrollView;
/**
 * tabbar实例
 */
-(void)setTabbarController;
/**
 * window实例
 */
-(void)setAppWindows;
/**
 * 根视图
 */
-(void)setRootViewController;

@end
