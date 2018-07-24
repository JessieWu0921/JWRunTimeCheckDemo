//
//  UIControl+FastEvent.m
//  JWRuntimeDemo
//
//  Created by JessieWu on 2018/7/24.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import "UIControl+FastEvent.h"

#import <objc/runtime.h>

@implementation UIControl (FastEvent)

- (void)setEventAcceptTime:(NSTimeInterval)eventAcceptTime {
    objc_setAssociatedObject(self, @"kEventTime", @(eventAcceptTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)eventAcceptTime {
    return [objc_getAssociatedObject(self, @"kEventTime") doubleValue];
}

+ (void)load {
    Method a = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod([self class], @selector(jw_sendAction:to:forEvent:));
    
    if (!class_addMethod([self class], @selector(jw_sendAction:to:forEvent:), method_getImplementation(b), method_getTypeEncoding(b))) {
        method_exchangeImplementations(a, b);
    }
    
//    method_exchangeImplementations(a, b);
}

#pragma mark - methods
- (void)jw_sendAction:(SEL)selector to:(id)target forEvent:(UIEvent *)event {
    static NSTimeInterval eventTime = 0.0;
    
    if (NSDate.date.timeIntervalSince1970 - eventTime < self.eventAcceptTime) {
        return;
    }
    eventTime = NSDate.date.timeIntervalSince1970;
}

@end
