//
//  HousingLoanVC.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "HousingLoanVC.h"
#import "WBPortsFile.h"
#import "TvShowVC.h"
#import "TvShowVC.h"
#import "ZJScrollPageView.h"
#import "WBIntroduceFile.h"
#import "TvShowRequest.h"

@interface HousingLoanVC ()

//数据源id
@property(nonatomic,strong)NSMutableArray* idArray;
//数据源title
@property(nonatomic,strong)NSMutableArray* titleArr;

@property(nonatomic,strong)TvShowVC* show;

@end

@implementation HousingLoanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电视节目单";
    [self getTVShowCategory];
    
}

#pragma mark - 获取节目类型
-(void)getTVShowCategory{
    [SVProgressHUD showProgress:0.8 status:@"数据加载中..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [[TvShowRequest shareInstance] getTvShowCategorySucess:^(NSMutableArray *title, NSMutableArray *idArray) {
        [self performOnMainThread:^{
            [SVProgressHUD dismiss];
            [self.titleArr addObjectsFromArray:title];
            [self.idArray addObjectsFromArray:idArray];
            [self CreateTopWithIndex];
        } wait:NO];
    }];
}

#pragma mark - 设置顶部滚动条
-(void)CreateTopWithIndex{
    //    NSInteger i = [index integerValue];
    //必要设置,未设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //是否显示遮盖
    style.showCover = YES;
    //segmentView是否有弹性
    style.segmentViewBounces = NO;
    //是否颜色渐变
    style.gradualChangeTitleColor = YES;
    //是否滚动标题
    style.scrollTitle = NO;
    NSMutableArray* vcs = [NSMutableArray array];
    for (int i = 1; i<self.idArray.count+1; i++) {
        self.show = [[TvShowVC alloc]init];
        self.show.title = self.titleArr[i-1];
        self.show.data = [NSMutableArray array];
        [self.show.data addObjectsFromArray:self.idArray];
        [self.show loadChannelWithId:[NSString stringWithFormat:@"%d",i]];
        [vcs addObject:self.show];
    }
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH , SCREENHEIGHT - 64.0) segmentStyle:style childVcs:vcs parentViewController:self];
    [self.view addSubview:scrollPageView];
}

-(NSMutableArray *)idArray{
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    return _idArray;
}

-(NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
