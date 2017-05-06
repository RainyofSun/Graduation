//
//  UIViewController+Loading.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Loading)

-(UIView*)loadingView;

-(void)showLoadingViewWithFrame:(CGRect)frame;

-(void)showLoadingView;

-(void)hideLoadingView;

@end
