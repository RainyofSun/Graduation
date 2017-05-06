//
//  ScenicAreaDetailCell.m
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "ScenicAreaDetailCell.h"
#import "WBBaseImageView.h"
#import <YYText.h>
#import <Masonry.h>
#import "ACMacros.h"

@interface ScenicAreaDetailCell ()

@property(nonatomic,strong)WBBaseImageView* detailImg;
@property(nonatomic,strong)YYLabel* title;
@property(nonatomic,strong)YYLabel* referral;
//立即购票
@property(nonatomic,strong)UIButton* buyTicket;
@end
@implementation ScenicAreaDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self detailImg];
        [self title];
        [self referral];
    }
    return self;
}

-(void)setDataSource:(ScenicAreaDetailModel *)dataSource{
    if (dataSource.img) {
        [self.detailImg setImageWithUrl:dataSource.img];
    }
    
    if (dataSource.title) {
        self.title.text = dataSource.title;
        self.title.textLayout = [self getTextLayout:dataSource.title];
    }else{
        self.title.text = @"暂无介绍";
        self.title.textLayout = [self getTextLayout:@"暂无介绍"];
    }
    
    if (dataSource.referral) {
        self.referral.text = dataSource.referral;
        self.referral.textLayout = [self getTextLayout:dataSource.referral];
    }
}

-(YYTextLayout*)getTextLayout:(NSString*)string{
    YYTextContainer* container = [YYTextContainer containerWithSize:CGSizeMake(Main_Screen_Width - 86, 50)];
    NSMutableAttributedString* arrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return [YYTextLayout layoutWithContainer:container text:arrStr];
}

-(void)layoutSubviews{
    [self.detailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(3);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width - 86, 50));
        make.leading.equalTo(self.detailImg.mas_trailing).with.offset(3);
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
    }];
    
    [self.referral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width - 86, 50));
        make.leading.equalTo(self.detailImg.mas_trailing).with.offset(3);
        make.top.equalTo(self.title.mas_bottom).with.offset(3);
    }];
}

#pragma mark - 懒加载
-(WBBaseImageView *)detailImg{
    if (!_detailImg) {
        _detailImg = [[WBBaseImageView alloc] init];
        _detailImg.layer.cornerRadius = 5.0f;
        _detailImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_detailImg];
    }
    return _detailImg;
}

-(YYLabel *)title{
    if (!_title) {
        _title = [[YYLabel alloc] init];
        _title.ignoreCommonProperties = YES;
        _title.displaysAsynchronously = YES;
        _title.numberOfLines = 0;
        [self.contentView addSubview:_title];
    }
    return _title;
}

-(YYLabel *)referral{
    if (!_referral) {
        _referral = [[YYLabel alloc] init];
        _referral.ignoreCommonProperties = YES;
        _referral.displaysAsynchronously = YES;
        _referral.numberOfLines = 0;
        [self.contentView addSubview:_referral];
    }
    return _referral;
}
@end
