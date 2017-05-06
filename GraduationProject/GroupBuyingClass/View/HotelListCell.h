//
//  HotelListCell.h
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableViewCell.h"
#import "HotelListModel.h"

@interface HotelListCell : WBTableViewCell

@property(nonatomic,strong)HotelListModel* dataSource;

@end
