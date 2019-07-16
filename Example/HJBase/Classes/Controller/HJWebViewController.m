//
//  HJWebViewController.m
//  HJBase_Example
//
//  Created by HeJun on 2019/7/16.
//  Copyright © 2019 HeJun. All rights reserved.
//

#import "HJWebViewController.h"
#import <HJWebView.h>

@interface HJWebViewController ()

@property (nonatomic, weak) HJWebView *webView;

@end

@implementation HJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)setupViews {
    HJWebView *webView = ({
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        HJWebView * webView = [[HJWebView alloc] initWithFrame:self.view.bounds configuration:config];
        //注册事件
        [webView bindWithName:@"ok" callback:^(id  _Nonnull obj) {
            NSLog(@"obj: %@", obj);
        }];
        webView;
    });
    //加载内容
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.hejun.org"]]];
    [self.view addSubview:webView];
    self.webView = webView;
    
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"JS调用WebView" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(100, 100, 100, 100);
        button.backgroundColor = [UIColor grayColor];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button;
    });
    [self.view addSubview:button];
    
}

#pragma mark - user event
- (void)handleButtonClick:(UIButton *)button {
    NSString *js = @"window.webkit.messageHandlers.ok.postMessage('success !')";
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"error: %@", error);
    }];
}

@end
