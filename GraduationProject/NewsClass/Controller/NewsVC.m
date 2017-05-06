//
//  NewsVC.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "NewsVC.h"
#import "WBIntroduceFile.h"
#import "ZJScrollPageView.h"
#import "NewsListVC.h"

@interface NewsVC ()

@property(nonatomic,strong)NSArray* titleArray;
@property(nonatomic,strong)NSArray* typeArray;
@property(nonatomic,strong)NewsListVC* newsList;

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻头条";
    self.titleArray = @[@"头条",@"社会",@"国内",@"国际",@"娱乐",@"体育",@"军事",@"科技",@"财经",@"时尚"];
    self.typeArray = @[@"top",@"shehui",@"guonei",@"guoji",@"yule",@"tiyu",@"junshi",@"keji",@"caijing",@"shishang"];
    [self CreateTopWithIndex];
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
    //标题之间的间隙
    style.titleMargin = 20;
    NSMutableArray* vcs = [NSMutableArray array];
    for (int i = 0; i<self.titleArray.count; i++) {
        self.newsList = [[NewsListVC alloc]init];
        self.newsList.title = self.titleArray[i];
        self.newsList.data = [NSMutableArray array];
        [self.newsList.data addObjectsFromArray:self.typeArray];
        [self.newsList loadNewsDataWithType:self.typeArray[i]];
        [vcs addObject:self.newsList];
    }
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH , SCREENHEIGHT - 64.0) segmentStyle:style childVcs:vcs parentViewController:self];
    [self.view addSubview:scrollPageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
