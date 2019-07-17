//
//  HJWebView.m
//  HJBase
//
//  Created by HeJun on 2019/7/16.
//  Copyright © 2019 HeJun. All rights reserved.
//

#import "HJWebView.h"
#import "HJWeakScriptMessageDelegate.h"

@interface HJWebView()<WKScriptMessageHandler>

@property (nonatomic, strong) NSMutableDictionary *binds;
@property (nonatomic, strong) HJWeakScriptMessageDelegate *delegate;

@end

@implementation HJWebView

- (void)dealloc {
    NSLog(@"%s", __func__);
    self.delegate = nil;
    self.binds = nil;
    for (NSString *name in self.binds.allKeys) {
        [self.configuration.userContentController removeScriptMessageHandlerForName:name];
    }
    if (!self.needRetainCache) {
        [self clearCache];
    }
}

/**
 绑定一个事件
 
 @param name 事件名
 @param callback 事件回调block
 */
- (void)bindWithName:(NSString *)name callback:(HJBaseWebViewCallback)callback {
    
    NSAssert(![self.binds.allKeys containsObject:name], @"不能绑定相同key");
    if ([self.binds.allKeys containsObject:name]) {
        return;
    }
    
    [self.configuration.userContentController addScriptMessageHandler:self.delegate name:name];
    
    [self.binds setObject:callback forKey:name];
}

/**
 解绑一个事件
 
 @param name 事件名
 */
- (void)unbindWithName:(NSString *)name {
    NSAssert([self.binds.allKeys containsObject:name], @"该事件暂未绑定，请先绑定！");
    if (![self.binds.allKeys containsObject:name]) {
        return;
    }
    [self.configuration.userContentController removeScriptMessageHandlerForName:name];
    [self.binds removeObjectForKey:name];
}

/**
 判断事件是否已经绑定过
 
 @param name 事件名
 @return 绑定状态
 */
- (BOOL)checkBindWithName:(NSString *)name {
    if ([self.binds.allKeys containsObject:name]) {
        return YES;
    }
    return NO;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.binds.allKeys containsObject:message.name]) {
        HJBaseWebViewCallback callback = self.binds[message.name];
        if (callback) {
            callback(message.body);
        }
    }
}

#pragma mark - private func

/**
 清除 WKWebView 缓存
 */
- (void)clearCache {
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    //    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
}

#pragma mark - lazyload
- (HJWeakScriptMessageDelegate *)delegate {
    if (_delegate == nil) {
        _delegate = [[HJWeakScriptMessageDelegate alloc] initWithDelegate:self];
    }
    return _delegate;
}
- (NSMutableDictionary *)binds {
    if (_binds == nil) {
        _binds = [NSMutableDictionary dictionary];
    }
    return _binds;
}

@end
