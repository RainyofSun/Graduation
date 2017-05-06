//
//  AdvertiseView.h
//  GraduationProject
//
//  Created by MS on 17/4/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface AdvertiseView : UIView

/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

@end
