//
//  ExpressVC.m
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "ExpressVC.h"
#import "WBIntroduceFile.h"
#import "SearchView.h"
#import "SearchDetailVC.h"
#import "ExpressSearchRequest.h"

@interface ExpressVC ()<SearchViewDelegate>

@property(nonatomic,strong)SearchView* search;

@end

@implementation ExpressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快递查询";
    [self search];
}

#pragma mark - 查询快递
-(void)searchExpressWithDict:(NSDictionary*)dict{
    WS(weakSelf);
    [[ExpressSearchRequest shareInstance] expressSearchWithNum:dict[@"num"] companyName:dict[@"company"] sucess:^(NSMutableArray *status, NSMutableArray *time, NSDictionary* dict) {
        [weakSelf performOnMainThread:^{
            SearchDetailVC* detail = [[SearchDetailVC alloc] init];
            detail.status = [NSMutableArray array];
            detail.time = [NSMutableArray array];
            [detail.status addObjectsFromArray:status];
            [detail.time addObjectsFromArray:time];
            detail.headDict = dict;
            [weakSelf pushVc:detail];
        } wait:NO];
    }];
}

#pragma mark - SearchViewDelegate
-(void)jumpTheSearchResultView:(NSDictionary*)dict{
    [self searchExpressWithDict:dict];
}

#pragma mark - 懒加载
-(SearchView *)search{
    if (!_search) {
        _search = [[SearchView alloc] init];
        _search.delegate = self;
        [self.view addSubview:_search];
        [_search mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.bottom.trailing.equalTo(self.view);
        }];
    }
    return _search;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
