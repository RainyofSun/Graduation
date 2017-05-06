//
//  MovieDetailCell.m
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "MovieDetailCell.h"
#import "ACMacros.h"
#import <Masonry.h>
#import "WBBaseImageView.h"
#import "MovieHallModel.h"
#import "MovieHallCell.h"

@interface MovieDetailCell ()<UICollectionViewDelegate,UICollectionViewDataSource,MovieHallCellDelegate>

//影片名字
@property(nonatomic,strong)UILabel* movieName;
//影片海报
@property(nonatomic,strong)WBBaseImageView* poster;
//厅
@property(nonatomic,strong)NSMutableArray* hallSource;
@property(nonatomic,strong)UICollectionView* hallView;

@end

@implementation MovieDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self poster];
        [self movieName];
        [self setUpCollectionView];
    }
    return self;
}

-(void)setDataSource:(MovieDetailModel *)dataSource{
    if (dataSource.movieName) {
        self.movieName.text = dataSource.movieName;
    }
    
    if (dataSource.pic_url) {
        [self.poster setImageWithUrl:dataSource.pic_url];
    }
    
    if (dataSource.broadcast) {
        self.hallSource = [MovieHallModel modelArrayWithDictArray:dataSource.broadcast];
    }
}

-(void)layoutSubviews{
    [self.poster mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.movieName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width - 20, 25));
        make.centerY.equalTo(self.poster.mas_centerY);
        make.leading.equalTo(self.poster.mas_trailing).with.offset(3);
    }];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hallSource.count;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(70, 135);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieHallCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hall" forIndexPath:indexPath];
    cell.hallModel = self.hallSource[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MovieHallCellDelegate
-(void)buyTickets:(NSString*)sender{
    if ([self.delegate respondsToSelector:@selector(ticketsShow:)]) {
        [self.delegate ticketsShow:sender];
    }
}

#pragma mark - 懒加载
-(WBBaseImageView *)poster{
    if (!_poster) {
        _poster = [[WBBaseImageView alloc] init];
        [self.contentView addSubview:_poster];
    }
    return _poster;
}

-(UILabel *)movieName{
    if (!_movieName) {
        _movieName = [[UILabel alloc] init];
        _movieName.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_movieName];
    }
    return _movieName;
}

-(void)setUpCollectionView{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.hallView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.hallView.delegate = self;
    self.hallView.dataSource = self;
    [self.contentView addSubview:self.hallView];
    [self.hallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.poster.mas_bottom).with.offset(3);
        make.leading.trailing.bottom.equalTo(self.contentView);
    }];
    [self.hallView registerClass:[MovieHallCell class] forCellWithReuseIdentifier:@"hall"];
}
@end
