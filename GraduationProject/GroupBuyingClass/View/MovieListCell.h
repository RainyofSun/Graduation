//
//  MovieListCell.h
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieListModel.h"

@interface MovieListCell : UICollectionViewCell

@property(nonatomic,strong)MovieListModel* dataSource;

@end
