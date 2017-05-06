//
//  TvShowVC.m
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "TvShowVC.h"
#import "WBBaseTableView.h"
#import "WBIntroduceFile.h"
#import "TVChannelCell.h"
#import "TvShowRequest.h"
#import "ZJSegmentStyle.h"
#import "TVShowListVC.h"
#import "TVChannelModel.h"

@interface TvShowVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WBBaseTableView* tableView;
@property(nonatomic,strong)NSMutableArray* dataSource;
@property(nonatomic,assign)int index;//顶部滑动栏的index

@end

@implementation TvShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    //顶部滚动条的监听
    [NSNotificationCenter addObserver:self action:@selector(scrollToPage:) name:ScrollPageViewDidShowThePageNotification];
}

#pragma mark - 加载频道列表
-(void)loadChannelWithId:(NSString*)pId{
    [self showLoadingAnimation];
    [[TvShowRequest shareInstance] TvShowChannelListSearch:pId sucess:^(NSMutableArray *dataSource) {
        [self performOnMainThread:^{
            [self stopLoadingAnimation];
            [self.dataSource addObjectsFromArray:dataSource];
            [self.tableView reloadData];
            [self tableViewStopRefresh:self.tableView];
        } wait:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVChannelCell* cell = [TVChannelCell cellWithTableView:tableView];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TVShowListVC* list = [[TVShowListVC alloc] init];
    TVChannelModel* model = self.dataSource[indexPath.row];
    list.channelId = model.rel;
    [self pushVc:list];
}

#pragma mark - 顶部滑动监听
-(void)scrollToPage:(NSNotification*)notification{
    [self performOnMainThread:^{
        self.index = [[[notification userInfo] objectForKey:@"currentIndex"] intValue];
    } wait:NO];
}

#pragma mark - 懒加载
-(WBBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self.view);
        }];
        [self tabelVewRefresh:_tableView actionBlock:^{
            [self loadChannelWithId:self.data[self.index]];
        }];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
