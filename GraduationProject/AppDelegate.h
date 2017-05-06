//
//  AppDelegate.h
//  GraduationProject
//
//  Created by yxkjios on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UIViewController* viewController;

/**
 * 获取根视图导航控制器
 */
+(UINavigationController*)rootNavigationController;
@end

