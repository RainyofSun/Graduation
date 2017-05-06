//
//  LifeCell.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//tableView里边镶嵌collectionView

#import "LifeCell.h"
#import "LifeCollectionViewCell.h"
#import "LifeCollectionModel.h"
#import <Masonry.h>

@interface LifeCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation LifeCell

-(void)setData:(NSArray *)array{
    [self.dataSource addObjectsFromArray:array];
    [self.collectionView reloadData];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

#pragma mark - 代理
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(70, 70);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LifeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    cell.model = [LifeCollectionModel loadDataWithDict:self.dataSource[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LifeCollectionModel* model = [LifeCollectionModel loadDataWithDict:self.dataSource[indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(pushDetailVC:)]) {
        [self.delegate pushDetailVC:model.title];
    }
}

#pragma mark - 懒加载
-(void)createUI{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0.0;
    //设置每个collectionViewCell的边距
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//上左下右
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.contentView addSubview:self.collectionView];
    [self addCollectionViewConstraint];
    //注册cell
    [self.collectionView registerClass:[LifeCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - collectionView约束
-(void)addCollectionViewConstraint{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.contentView);
    }];
}

@end
