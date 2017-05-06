//
//  MovieVC.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "MovieVC.h"
#import "WBIntroduceFile.h"
#import "GroupBuyingReqeust.h"
#import "MovieCityListModel.h"
#import "MovieListCell.h"
#import "MovieDetailVC.h"

static NSInteger page;
@interface MovieVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

//城市的数据
@property(nonatomic,strong)NSMutableArray* cityListAry;
//影院的数据
@property(nonatomic,strong)NSMutableArray* movieDataSource;
@property(nonatomic,strong)UICollectionView* collectionView;
/**标记--->是否是下拉刷新还是下拉加载*/
@property(nonatomic,assign)BOOL isRefresh;

@end

@implementation MovieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"影院";
    page = 1;
    self.isRefresh = NO;//默认是上拉加载
//    [self getCityList];
    [self collectionView];
}

#pragma mark - 获取城市列表
-(void)getCityList{
    [[GroupBuyingReqeust shareInstance] getMovieCityListSucess:^(NSMutableArray *dataSource) {
        [self.cityListAry addObjectsFromArray:dataSource];
        for (int i = 0; i < self.cityListAry.count; i++) {
            MovieCityListModel* list = self.cityListAry[i];
            if ([list.city_name isEqualToString:self.cityName]) {
                [self getMovieList:list.id page:[NSString stringWithFormat:@"%ld",(long)page]];
                break;
            }
        }
    }];
}

#pragma mark - 获取影院列表
-(void)getMovieList:(NSString*)movieId page:(NSString*)page{
    WS(weakSelf);
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [[GroupBuyingReqeust shareInstance] getMovieSearchWithCityId:movieId page:page sucess:^(NSMutableArray *dataSource) {
        [weakSelf performOnMainThread:^{
            [SVProgressHUD dismiss];
            [weakSelf.movieDataSource addObjectsFromArray:dataSource];
            [weakSelf.collectionView reloadData];
            [weakSelf collectionViewStopRefresh:weakSelf.collectionView];
            [weakSelf collectionViewStopLoadingMore:weakSelf.collectionView dataCount:weakSelf.movieDataSource];
        } wait:NO];
    }];
}

#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(SCREENWIDTH/2-10, SCREENWIDTH/2-10);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movieDataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieListCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.dataSource = self.movieDataSource[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailVC* detail = [[MovieDetailVC alloc] init];
    detail.movie = self.movieDataSource[indexPath.row];
    [self pushVc:detail];
}

#pragma mark - 懒加载
-(NSMutableArray *)cityListAry{
    if (!_cityListAry) {
        _cityListAry = [NSMutableArray array];
    }
    return _cityListAry;
}

-(NSMutableArray *)movieDataSource{
    if (!_movieDataSource) {
        _movieDataSource = [NSMutableArray array];
    }
    return _movieDataSource;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.trailing.leading.bottom.equalTo(self.view);
        }];
        [_collectionView registerClass:[MovieListCell class] forCellWithReuseIdentifier:@"cell"];
        [self collectionViewRefresh:_collectionView actionBlock:^{
            page = 1;
            self.isRefresh = YES;
            [self getCityList];
        }];
        [self collectionViewLodingMore:_collectionView sctionBlock:^{
            page++;
            [self getCityList];
        }];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
