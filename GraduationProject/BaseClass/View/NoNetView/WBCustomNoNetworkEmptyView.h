//
//  WBCustomNoNetworkEmptyView.h
//  BXYJWB
//
//  Created by MS on 17/1/17.
//  Copyright © 2017年 yxkjios. All rights reserved.
//  没有网络时候显示的视图

#import <UIKit/UIKit.h>

@interface WBCustomNoNetworkEmptyView : UIView

/**没有网络,重试*/
@property(nonatomic,copy)void(^customNoNetworkEmptyViewDidClickRetryHandle)(WBCustomNoNetworkEmptyView* view);
@end
