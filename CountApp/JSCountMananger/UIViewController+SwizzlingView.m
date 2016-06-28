//
//  UIViewController+SwizzlingView.m
//  JumpUpAndDown
//
//  Created by stefanie on 16/6/8.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "UIViewController+SwizzlingView.h"

#import "JSHookUtility.h"
#import "JSClick.h"

#import "UMMobClick/MobClick.h"


@implementation UIViewController (SwizzlingView)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzlingSelector = @selector(swiz_viewWillAppear:);
        [JSHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzlingSelector];
        
        SEL originalSelector1 = @selector(viewWillDisappear:);
        SEL swizzlingSelector1 = @selector(swiz_viewWillDisappear:);
        [JSHookUtility swizzlingInClass:[self class] originalSelector:originalSelector1 swizzledSelector:swizzlingSelector1];
    });
}

- (void)swiz_viewWillAppear:(BOOL)animated {
    
    NSString *className = NSStringFromClass([self class]);
    if (![className isEqualToString:@"UINavigationController"] && ![className isEqualToString:@"UIInputWindowController"] && ![className isEqualToString:@"UICompatibilityInputViewController"]) {
        [MobClick beginLogPageView:className];
        [JSClick enterPageView:className timeType:M5_DATA];
    }
    [self swiz_viewWillAppear:animated];
}

- (void)swiz_viewWillDisappear:(BOOL)animated {
    
    NSString *className = NSStringFromClass([self class]);
    if (![className isEqualToString:@"UINavigationController"] && ![className isEqualToString:@"UIInputWindowController"] && ![className isEqualToString:@"UICompatibilityInputViewController"]) {
        [MobClick endLogPageView:className];
        [JSClick leavePageView:className timeType:M5_DATA pageType:nil objectid:nil];
    }
    [self swiz_viewWillDisappear:animated];
}

@end
