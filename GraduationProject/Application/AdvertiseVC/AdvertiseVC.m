//
//  AdvertiseVC.m
//  GraduationProject
//
//  Created by MS on 17/4/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "AdvertiseVC.h"
#import <WebKit/WebKit.h>

@interface AdvertiseVC ()

@property(nonatomic,strong)WKWebView* webView;

@end

@implementation AdvertiseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告链接";
    [self webView];
    if (!self.adUrl) {
        self.adUrl = @"http://www.jianshu.com";
    }
    [self loadRequest:self.adUrl];
}

-(void)loadRequest:(NSString*)url{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

-(void)setAdUrl:(NSString *)adUrl{
    _adUrl = adUrl;
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
