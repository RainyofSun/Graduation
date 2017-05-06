//
//  MovieDetailVC.m
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "MovieDetailVC.h"
#import "WBIntroduceFile.h"
#import "GroupBuyingReqeust.h"
#import "WBBaseTableView.h"
#import "MovieDetailHeadView.h"
#import "MovieDetailCell.h"
#import "UrlVC.h"
#import "ShowGDMap.h"

@interface MovieDetailVC ()<UITableViewDelegate,UITableViewDataSource,MovieDetailCellDelegate>

//影院影片信息
@property(nonatomic,strong)NSMutableArray* movieDetailDataSource;
@property(nonatomic,strong)WBBaseTableView* tableView;

@end

@implementation MovieDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"影院详情";
    [self tableView];
    [self getMovieDetail:self.movie.id];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRightNavItemWithImage:@"ios7_top_navigation_locationicon" target:self action:@selector(movieLocation:) type:1];
}

#pragma mark - 获取影院内上线电影
-(void)getMovieDetail:(NSString*)movieId{
    WS(weakSelf);
    [[GroupBuyingReqeust shareInstance] getMovieDetailMsg:movieId sucess:^(NSMutableArray *dataSource) {
        [weakSelf performOnMainThread:^{
            [weakSelf.movieDetailDataSource addObjectsFromArray:dataSource];
            [weakSelf.tableView reloadData];
        } wait:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieDetailDataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 110;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        MovieDetailHeadView* head = [MovieDetailHeadView headerFooterViewWithTableView:tableView];
        head.address.text = self.movie.address;
        head.moviePhone.text = self.movie.telephone;
        head.movieTitle.text = self.movie.cinemaName;
        head.movieTransport.text = self.movie.trafficRoutes;
        head.movieTransport.textLayout = [self textLayoutWithStr:self.movie.trafficRoutes];
        return head;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailCell* detail = [MovieDetailCell cellWithTableView:tableView];
    detail.dataSource = self.movieDetailDataSource[indexPath.row];
    detail.delegate = self;
    return detail;
}

#pragma mark - MovieDetailCellDelegate
-(void)ticketsShow:(NSString*)sender{
    UrlVC* url = [[UrlVC alloc] init];
    url.connection = sender;
    [self pushVc:url];
}

-(YYTextLayout*)textLayoutWithStr:(NSString*)str{
    YYTextContainer* container = [YYTextContainer containerWithSize:CGSizeMake(Main_Screen_Width - 20, 40)];
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];;
    YYTextLayout* textLayout = [YYTextLayout layoutWithContainer:container text:attStr];
    return textLayout;
}

#pragma mark - movie location
-(void)movieLocation:(UIGestureRecognizer*)sender{
    ShowGDMap* map = [[ShowGDMap alloc] init];
    map.location = @{@"lon":[NSString stringWithFormat:@"%f",self.movie.longitude],
                     @"lat":[NSString stringWithFormat:@"%f",self.movie.latitude]};
    map.storeName = self.movie.cinemaName;
    map.storeAddress = self.movie.address;
    [self pushVc:map];
}

#pragma mark - 懒加载
-(NSMutableArray *)movieDetailDataSource{
    if (!_movieDetailDataSource) {
        _movieDetailDataSource = [NSMutableArray array];
    }
    return _movieDetailDataSource;
}

-(WBBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self.view);
        }];
        UIView* detail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.1)];
        _tableView.tableHeaderView = detail;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
