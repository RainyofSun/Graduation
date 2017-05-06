//
//  RecommondDetailVC.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "RecommondDetailVC.h"
#import "WBIntroduceFile.h"
#import "RecommodDetailView.h"
#import "ShowGDMap.h"

@interface RecommondDetailVC ()

@property(nonatomic,strong)RecommodDetailView* detailView;

@end

@implementation RecommondDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺详情";
    [self detailView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRightNavItemWithImage:@"ios7_top_navigation_locationicon" target:self action:@selector(locationCityGroupBuy:) type:1];
}

-(void)locationCityGroupBuy:(UIGestureRecognizer*)sender{
    ShowGDMap* map = [[ShowGDMap alloc] init];
    map.location = @{
                     @"lon":[NSString stringWithFormat:@"%f",self.dataSource.longitude],
                     @"lat":[NSString stringWithFormat:@"%f",self.dataSource.latitude]};
    map.storeName = self.dataSource.name;
    map.storeAddress = self.dataSource.address;
    [self pushVc:map];
}

#pragma mark - 懒加载
-(RecommodDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[RecommodDetailView alloc] initWithFrame:CGRectZero data:self.dataSource];
        [self.view addSubview:_detailView];
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self.view);
        }];
    }
    return _detailView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
