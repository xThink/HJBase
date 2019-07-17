//
//  HJWebView.h
//  HJBase
//
//  Created by HeJun on 2019/7/16.
//  Copyright © 2019 HeJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void(^HJBaseWebViewCallback)(id _Nonnull obj);

NS_ASSUME_NONNULL_BEGIN

@interface HJWebView : WKWebView

/** 是否需要保持缓存 */
@property (nonatomic, assign) BOOL needRetainCache;

/**
 绑定一个事件
 
 @param name 事件名
 @param callback 事件回调block
 */
- (void)bindWithName:(NSString *)name
            callback:(HJBaseWebViewCallback _Nonnull )callback;
/**
 解绑一个事件
 
 @param name 事件名
 */
- (void)unbindWithName:(NSString *)name;
/**
 判断事件是否已经绑定过
 
 @param name 事件名
 @return 绑定状态
 */
- (BOOL)checkBindWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
