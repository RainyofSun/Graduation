//
//  MovieHallCell.h
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieHallModel.h"

@protocol MovieHallCellDelegate <NSObject>

//跳转订票界面
-(void)buyTickets:(NSString*)sender;

@end

@interface MovieHallCell : UICollectionViewCell

@property(nonatomic,weak)id<MovieHallCellDelegate>delegate;

@property(nonatomic,strong)MovieHallModel* hallModel;

@end
