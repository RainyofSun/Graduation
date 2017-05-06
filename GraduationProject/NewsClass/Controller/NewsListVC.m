//
//  NewsListVC.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "NewsListVC.h"
#import "NewsRequest.h"
#import "NewsCell.h"
#import "NewsCellTwo.h"
#import "NewsCellThree.h"
#import "WBBaseTableView.h"
#import "WBIntroduceFile.h"
#import "ZJScrollPageView.h"
#import "NewListDetailVC.h"

@interface NewsListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WBBaseTableView* tableView;
@property(nonatomic,strong)NSMutableArray* dataSource;
@property(nonatomic,assign)int index;//滚动条的下标

@end

@implementation NewsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    //顶部滚动条的监听
    [NSNotificationCenter addObserver:self action:@selector(scrollToPageNews:) name:ScrollPageViewDidShowThePageNotification];
}

-(void)loadNewsDataWithType:(NSString *)type{
    [self showLoadingAnimation];
    [[NewsRequest shareInstance] getNewsDataWithType:type sucess:^(NSMutableArray *dataSource) {
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel* model = self.dataSource[indexPath.row];
    if (!model.thumbnail_pic_s02 && !model.thumbnail_pic_s03) {
        return 100;
    } else if (model.thumbnail_pic_s02 && !model.thumbnail_pic_s03){
        return 160;
    } else if (model.thumbnail_pic_s03){
        return 160;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel* model = self.dataSource[indexPath.row];
    if (!model.thumbnail_pic_s02 && !model.thumbnail_pic_s03) {
        NewsCell* cell = [NewsCell cellWithTableView:tableView];
        cell.modelSource = model;
        return cell;
    }
    if (model.thumbnail_pic_s02 && !model.thumbnail_pic_s03) {
        NewsCellTwo* cell = [NewsCellTwo cellWithTableView:tableView];
        cell.modelSource = model;
        return cell;
    }
    if (model.thumbnail_pic_s03) {
        NewsCellThree* cell = [NewsCellThree cellWithTableView:tableView];
        cell.modelSource = model;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewListDetailVC* detail = [[NewListDetailVC alloc] init];
    NewsModel* model = self.dataSource[indexPath.row];
    detail.articleUrl = model.url;
    [self pushVc:detail];
}

#pragma mark - 滚动条监听
-(void)scrollToPageNews:(NSNotification*)notification{
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
            make.leading.top.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-kBottomBarHeight);
        }];
        [self tabelVewRefresh:_tableView actionBlock:^{
            [self loadNewsDataWithType:self.data[self.index]];
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
