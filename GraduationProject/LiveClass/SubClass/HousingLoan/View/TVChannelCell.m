//
//  TVChannelCell.m
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "TVChannelCell.h"
#import <Masonry.h>

@interface TVChannelCell ()

@property(nonatomic,strong)UILabel* channelName;

@end

@implementation TVChannelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self channelName];
    }
    return self;
}

-(void)setModel:(TVChannelModel *)model{
    if (model.channelName) {
        self.channelName.text = model.channelName;
    }
}

-(void)layoutSubviews{
    [self.channelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.top.equalTo(self);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(10);
    }];
}

#pragma mark - 懒加载
-(UILabel *)channelName{
    if (!_channelName) {
        _channelName = [[UILabel alloc] init];
        [self.contentView addSubview:_channelName];
    }
    return _channelName;
}

@end
