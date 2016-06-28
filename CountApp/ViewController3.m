//
//  ViewController3.m
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "ViewController3.h"

@import WebKit;

@import SafariServices;

@interface ViewController3() <WKUIDelegate, WKNavigationDelegate, SFSafariViewControllerDelegate>

@end
@implementation ViewController3
{
    WKWebView *_webView;
    SFSafariViewController *_sfViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"页面3";
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    
    config.selectionGranularity = WKSelectionGranularityCharacter;
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.qq.com"]]];
    [self.view addSubview:_webView];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.allowsBackForwardNavigationGestures =YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

@end
