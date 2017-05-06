//
//  SearchDetailVC.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "SearchDetailVC.h"
#import "DWQLogisticModel.h"
#import "DWQLogisticsView.h"
#import "DWQConfigFile.h"

@interface SearchDetailVC ()

@property (strong, nonatomic)NSMutableArray *dataArray;

@end

@implementation SearchDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流详情";
    [self loadData];
}

#pragma mark 下载数据
-(void)loadData{
    for (NSInteger i = self.status.count-1; i>=0 ; i--) {
        DWQLogisticModel *model = [[DWQLogisticModel alloc]init];
        model.dsc = [self.status objectAtIndex:i];
        model.date = [self.time objectAtIndex:i];
        [self.dataArray addObject:model];
    }
    DWQLogisticsView* logis = [[DWQLogisticsView alloc] initWithFrame:CGRectMake(0, 0, DWQScreenWidth, DWQScreenHeight-49) datas:self.dataArray dict:self.headDict];
    [self.view addSubview:logis];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
