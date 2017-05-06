//
//  LifeCollectionViewCell.h
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//封装的collectionViewcell

#import <UIKit/UIKit.h>
#import "LifeCollectionModel.h"

@interface LifeCollectionViewCell : UICollectionViewCell

//数据模型
@property(nonatomic,strong)LifeCollectionModel* model;

@end
