//
//  RecommodDetailView.h
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupBuyingModel.h"

@interface RecommodDetailView : UIView

/**
 * 重写init
 */
-(instancetype)initWithFrame:(CGRect)frame data:(GroupBuyingModel*)model;
@end
