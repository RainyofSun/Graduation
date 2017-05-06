//
//  OilHeadView.m
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "OilHeadView.h"
#import <Masonry.h>

@interface OilHeadView ()

//背景图
@property(nonatomic,strong)UIImageView* backgroudImage;


@end

@implementation OilHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self backgroudImage];
        [self update];
    }
    return self;
}

-(void)layoutSubviews{
    [self.backgroudImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
    
    [self.update mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
}

#pragma mark - 懒加载
-(UIImageView *)backgroudImage{
    if (!_backgroudImage) {
        _backgroudImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"oilPrice.jpeg"]];
        [self addSubview:_backgroudImage];
    }
    return _backgroudImage;
}

-(UILabel *)update{
    if (!_update) {
        _update = [[UILabel alloc] init];
        _update.textColor = [UIColor redColor];
        _update.textAlignment = NSTextAlignmentCenter;
        [self.backgroudImage addSubview:_update];
    }
    return _update;
}

@end
