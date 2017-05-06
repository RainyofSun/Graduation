//
//  CurrencyVC.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "CurrencyVC.h"
#import "WBBaseTableView.h"
#import "CurrencyCell.h"
#import "CurrencyReqeust.h"
#import "OilHeadView.h"
#import "WBIntroduceFile.h"

@interface CurrencyVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WBBaseTableView* tableView;
@property(nonatomic,strong)NSMutableArray* dataSource;
//更新时间
@property(nonatomic,copy)NSString* updateTime;

@end

@implementation CurrencyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日油价";
    [self tableView];
    [self loadOilPrice];
}

#pragma mark - 加载油价
-(void)loadOilPrice{
    [self showLoadingAnimation];
    [[CurrencyReqeust shareInstance] oilPriceQuerySucess:^(NSMutableArray *dataSource, NSString *updateTime) {
        [self performOnMainThread:^{
            [self stopLoadingAnimation];
            self.updateTime = [VTGeneralTool getDateWithType:@"YYYY-MM-dd hh:mm:ss"];
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
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CurrencyCell* cell = [CurrencyCell cellWithTableView:tableView];
    cell.modelSource = self.dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OilHeadView* head = [OilHeadView headerFooterViewWithTableView:tableView];
    [self performOnMainThread:^{
        [head.update setText:AppendString(@"更新时间:%@", self.updateTime)];
    } wait:NO];
    return head;
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
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableView.tableHeaderView = view;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.top.equalTo(self.view);
        }];
        [self tabelVewRefresh:_tableView actionBlock:^{
            [self loadOilPrice];
        }];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
