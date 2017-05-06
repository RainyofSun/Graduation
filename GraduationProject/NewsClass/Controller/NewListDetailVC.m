//
//  NewListDetailVC.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "NewListDetailVC.h"
#import <WebKit/WebKit.h>
#import "WBIntroduceFile.h"

@interface NewListDetailVC ()<WKNavigationDelegate>

@property(nonatomic,strong)WKWebView* webView;

@end

@implementation NewListDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webView];
    [self loadArticle:self.articleUrl];
}

#if 0
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置透明背景图片,空图片,连图片文件也可以不需要
    UIImage* image = [[UIImage alloc] init];
    [[self rdv_tabBarController].navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //去除透明后导航栏下边的黑边
    [[self rdv_tabBarController].navigationController.navigationBar setShadowImage:image];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //重置导航栏的透明度
    [[self rdv_tabBarController].navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [[self rdv_tabBarController].navigationController.navigationBar setShadowImage:nil];
}

-(void)setUpLeftNav{
    CGSize btnSize = [UIImage imageNamed:@"back"].size;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 5, btnSize.width, btnSize.height);
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* left = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = left;
}
#pragma mark - 返回上一页
-(void)back:(UIButton*)sender{
    [self pop];
}
#endif

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self loadArticle:self.articleUrl];
}

#pragma mark - WKNavigationDelegate
//页面刚开始加载中
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showWithStatus:@"页面正在加载中"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}
//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}

//页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"页面加载失败,点击页面重新加载"];
}

#pragma mark - 加载文章
-(void)loadArticle:(NSString*)url{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark - 懒加载
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:Application_Bounds];
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
