//
//  ViewController.m
//  JWRuntimeDemo
//
//  Created by JessieWu on 2018/7/24.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import "ViewController.h"

#import "JWPerson.h"
#import "UIControl+FastEvent.h"
#import "UILabel+textColor.h"

#import <objc/runtime.h>
#import <objc/objc.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self checkObjectInfo];
//    [self getAllMethods];
    
    //
    UILabel *label = [UILabel new];
    label.text = @"fheufeiojfoesjehfefheufheuhfeufheuhfkshkfjheuffbhjsnckdkjslkfejofjsleksljekkhguehguksejkjfiegjekhfeisnkfj\njfoejfeioajfjoaeofjojeoifajeiojfoeijaoe\n";
    CGRect labelFrame = [label textRectForBounds:CGRectMake(10, 100, 100, 100) limitedToNumberOfLines:3];
    NSLog(@"labelframe is: %@", [NSValue valueWithCGRect:labelFrame]);
}

#pragma mark - methods
- (void)checkObjectInfo {
    //ivar & property
    Class currentClass = [JWPerson class];
    while ([currentClass isEqual:[JWPerson class]]) {
        unsigned int ivarCount = 0;
        Ivar *varList = class_copyIvarList(currentClass, &ivarCount);
        unsigned int i = 0;
        for (; i < ivarCount; i++) {
            NSLog(@"%@ - %@", [NSString stringWithCString:class_getName([JWPerson class]) encoding:NSUTF8StringEncoding], [NSString stringWithCString:ivar_getName(varList[i]) encoding:NSUTF8StringEncoding]);
        }
        free(varList);
        NSLog(@"ivar count is: %d", ivarCount);
        
        unsigned int propertyCount = 0;
        objc_property_t *propertyList = class_copyPropertyList(currentClass, &propertyCount);
        unsigned int j = 0;
        for (; j < propertyCount; j++) {
            NSLog(@"%@ - %@", [NSString stringWithCString:class_getName(currentClass) encoding:NSUTF8StringEncoding], [NSString stringWithCString:property_getName(propertyList[j]) encoding:NSUTF8StringEncoding]);
        }
        free(propertyList);
        NSLog(@"property count is: %d", propertyCount);
        
        currentClass = class_getSuperclass(currentClass);
    }
}

- (void)getAllMethods {
    Class currentClass = [UILabel class];
    while ([currentClass isEqual:[UILabel class]]) {
        unsigned int methodCount = 0;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        unsigned int i = 0;
        for (; i < methodCount; i++) {
            NSLog(@"%@ - %@",[NSString stringWithCString:class_getName(currentClass) encoding:NSUTF8StringEncoding], [NSString stringWithCString:sel_getName(method_getName(methodList[i])) encoding:NSUTF8StringEncoding]);
        }
        free(methodList);
        NSLog(@"methods count: %d", methodCount);
        
        currentClass = class_getSuperclass(currentClass);
    }
}

- (void)getAllCategory {
//    Class currentClass = [UILabel class];
//    while ([currentClass isEqual:[UILabel class]]) {
//        unsigned int categoryCount = 0;
//        Category category =
//    }
}

@end
