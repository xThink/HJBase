//
//  HJWeakScriptMessageDelegate.m
//  HJBase
//
//  Created by HeJun on 2019/7/16.
//  Copyright © 2019 HeJun. All rights reserved.
//

#import "HJWeakScriptMessageDelegate.h"

@implementation HJWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    if (self = [super init]) {
        self.scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
