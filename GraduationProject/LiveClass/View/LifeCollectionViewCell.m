//
//  LifeCollectionViewCell.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "LifeCollectionViewCell.h"
#import <Masonry.h>

@interface LifeCollectionViewCell ()

//图片
@property(nonatomic,strong)UIImageView* imageView;
//标题
@property(nonatomic,strong)UILabel* title;

@end

@implementation LifeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self imageView];
        [self title];
    }
    return self;
}

-(void)setModel:(LifeCollectionModel *)model{
    if (model.imageName) {
        self.imageView.image = [UIImage imageNamed:model.imageName];
    }
    if (model.title) {
        self.title.text = model.title;
    }
}

-(void)layoutSubviews{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 60));
        make.leading.equalTo(self.contentView.mas_leading);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 15));
        make.leading.equalTo(self.contentView.mas_leading);
        make.top.equalTo(self.imageView.mas_bottom).with.offset(10);
    }];
}

#pragma mark - 懒加载
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:13];
        _title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_title];
    }
    return _title;
}

@end
