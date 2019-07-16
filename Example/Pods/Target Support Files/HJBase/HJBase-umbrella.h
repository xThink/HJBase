#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HJBase.h"
#import "HJWeakScriptMessageDelegate.h"
#import "HJWebView.h"

FOUNDATION_EXPORT double HJBaseVersionNumber;
FOUNDATION_EXPORT const unsigned char HJBaseVersionString[];

