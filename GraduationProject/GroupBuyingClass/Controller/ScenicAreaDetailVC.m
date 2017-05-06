//
//  ScenicAreaDetailVC.m
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "ScenicAreaDetailVC.h"
#import "WBIntroduceFile.h"
#import "GroupBuyingReqeust.h"
#import "ScenicAreaDetailCell.h"

@interface ScenicAreaDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WBBaseTableView* tableView;
@property(nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation ScenicAreaDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"景点详情";
    [self tableView];
    [self loadDataWithId:self.spot.sid];
}

-(void)loadDataWithId:(NSString*)spotid{
    WS(weakSelf);
    [self showLoadingAnimation];
    [[GroupBuyingReqeust shareInstance] getScenicAreaDetail:spotid sucess:^(NSMutableArray *dataSource) {
        [weakSelf performOnMainThread:^{
            [weakSelf stopLoadingAnimation];
            [weakSelf.dataSource addObjectsFromArray:dataSource];
            [weakSelf.tableView reloadData];
        } wait:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScenicAreaDetailCell* cell = [ScenicAreaDetailCell cellWithTableView:tableView];
    cell.dataSource = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - 懒加载
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(WBBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self.view);
        }];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
