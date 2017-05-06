//
//  UrlVC.m
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "UrlVC.h"
#import <WebKit/WebKit.h>
#import "WBIntroduceFile.h"

@interface UrlVC ()<WKNavigationDelegate>

@property(nonatomic,strong)WKWebView* webView;

@end

@implementation UrlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webView];
    [self loadWithUrl:self.connection];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self loadWithUrl:self.connection];
}

-(void)loadWithUrl:(NSString*)url{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
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


#pragma mark - 懒加载
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
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
