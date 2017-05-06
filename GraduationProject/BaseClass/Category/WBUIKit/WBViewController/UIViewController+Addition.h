//
//  UIViewController+Addition.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Addition)
/**
 * 判断是否时正在显示的控制器
 */
-(BOOL)isCurrentAndVisibleViewController;
-(void)pushToNextViewController:(UIViewController*)nextVC;
@end
