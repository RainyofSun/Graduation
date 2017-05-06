//
//  DeliciousFoodVC.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "DeliciousFoodVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface DeliciousFoodVC ()<UISearchBarDelegate,AMapSearchDelegate>

@property(nonatomic,strong)UISearchBar* searchView;
@property(nonatomic,strong)AMapSearchAPI* search;

@end

@implementation DeliciousFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchView];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

#pragma mark - 发起搜索
-(void)startSearch:(NSString*)searchClass{
    AMapPOIKeywordsSearchRequest* reqeust = [[AMapPOIKeywordsSearchRequest alloc] init];
    reqeust.keywords = searchClass;
    reqeust.requireExtension = YES;
    /*
     只搜索本城市的POI
     request.cityLimit           = YES;
     request.requireSubPOIs      = YES;
     */
    [self.search AMapPOIKeywordsSearch:reqeust];
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self startSearch:searchBar.text];
}

#pragma mark - AMapSearchDelegate
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count == 0){
        return;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchView resignFirstResponder];
}

-(UISearchBar *)searchView{
    if (!_searchView) {
        _searchView = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _searchView.placeholder = @"请输入搜索词";
        _searchView.delegate = self;
        self.navigationItem.titleView = _searchView;
    }
    return _searchView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
