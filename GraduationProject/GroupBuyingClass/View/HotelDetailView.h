//
//  HotelDetailView.h
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelListModel.h"
#import <YYText.h>

@protocol HotelDetailViewDelegate <NSObject>

//预定酒店
-(void)customHotelSetting:(id)sender;

@end

@interface HotelDetailView : UIView

@property(nonatomic,weak)id<HotelDetailViewDelegate>delegate;
@property(nonatomic,strong)HotelListModel* model;
//酒店简介
@property(nonatomic,strong)YYLabel* hotelMessage;
//酒店服务
@property(nonatomic,strong)YYLabel* hotelService;
//房间设置
@property(nonatomic,strong)YYLabel* hotelRoomSetting;
//酒店设施
@property(nonatomic,strong)YYLabel* hotelSetting;
//餐厅配置
@property(nonatomic,strong)UILabel* foodSetting;
//入住政策
@property(nonatomic,strong)YYLabel* hotelPolicy;

@end
