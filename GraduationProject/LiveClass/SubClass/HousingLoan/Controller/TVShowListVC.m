//
//  TVShowListVC.m
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "TVShowListVC.h"
#import "WBIntroduceFile.h"
#import "WBBaseTableView.h"
#import "TVShowListCell.h"
#import "TvShowRequest.h"
#import "TvShowListModel.h"
#import "ShowPalyVC.h"

@interface TVShowListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WBBaseTableView* tableView;
@property(nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation TVShowListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"节目列表";
    [self tableView];
    [self getShowList:self.channelId];
}

#pragma mark - 界面列表
-(void)getShowList:(NSString*)channelId{
    [[TvShowRequest shareInstance] TvShowList:channelId sucess:^(NSMutableArray *dataSource) {
        [self performOnMainThread:^{
            [self.dataSource addObjectsFromArray:dataSource];
            [self.tableView reloadData];
        } wait:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVShowListCell* cell = [TVShowListCell cellWithTableView:tableView];
    cell.modelSource  = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TvShowListModel* model = self.dataSource[indexPath.row];
    ShowPalyVC* show = [[ShowPalyVC alloc] init];
    show.playUrl = model.pUrl;
    show.showName = model.pName;
    [self pushVc:show];
}

#pragma mark - 懒加载
-(WBBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.trailing.bottom.equalTo(self.view);
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
