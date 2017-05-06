//
//  UIViewController+Addition.m
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "UIViewController+Addition.h"

@implementation UIViewController (Addition)

-(BOOL)isCurrentAndVisibleViewController{
    return self.isViewLoaded && self.view.window;
}

-(void)pushToNextViewController:(UIViewController *)nextVC{
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
