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

#import "JWSample.h"
#import "JWSampleString.h"

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
//    UILabel *label = [UILabel new];
//    label.text = @"fheufeiojfoesjehfefheufheuhfeufheuhfkshkfjheuffbhjsnckdkjslkfejofjsleksljekkhguehguksejkjfiegjekhfeisnkfj\njfoejfeioajfjoaeofjojeoifajeiojfoeijaoe\n";
//    CGRect labelFrame = [label textRectForBounds:CGRectMake(10, 100, 100, 100) limitedToNumberOfLines:3];
//    NSLog(@"labelframe is: %@", [NSValue valueWithCGRect:labelFrame]);
    
//    JWPerson *person = [[JWPerson alloc] init];
//    [person definedFunction];
//    [self getIMPForSel:@selector(definedFunction)];
    
//    [self getClassInstanceHash];
    
//    [self getAllMethods:[JWPerson class]];
    
//    [self getAllCategory:[JWPerson class]];
    
//    [self getClassList:[JWPerson class]];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @""]] options:@{} completionHandler:nil];
    
    //isa swizzling
    [self changClassInstanceIsa];
}

#pragma mark - methods
//isa swizzling
- (void)changClassInstanceIsa {
    JWSample *sample = [JWSample new];
    //isa 指向 JWSampleString
    object_setClass(sample, [JWSampleString class]);
    //调用JWSampleString中的方法 loadingString（）
    [sample performSelector:@selector(loadingString)];
    //将isa 指回 JWSample (注释掉此行可以追踪下sampleStringToLoad可以验证isa是否已经指向了新的class)
    object_setClass(sample, [JWSample class]);
    
    NSLog(@"%@", sample.sampleStringToLoad);
}

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

- (void)getAllMethods:(Class)class {
    Class currentClass = class;
    while ([currentClass isEqual:class]) {
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

- (void)getIMPForSel:(SEL)selector {
    Class currentClass = [JWPerson class];
    IMP imp = class_getMethodImplementation(currentClass, selector);
    NSLog(@"%p", imp);
}

- (void)getClassList:(Class)class {
//    Class currentClass = class;
//    int classCount = 0;
//    objc_getClassList(&currentClass, classCount);
    
    while ([class isEqual:[JWPerson class]]) {
        unsigned int classCount = 0;
        Class *classList = objc_copyClassList(&classCount);
        unsigned int i = 0;
        for (; i < classCount; i++) {
            NSLog(@" %@", [NSString stringWithCString:class_getName(classList[i]) encoding:NSUTF8StringEncoding]); //[NSString stringWithCString:class_getName(class) encoding:NSUTF8StringEncoding],
        }
        
        class = [NSObject class];
    }
}

- (void)classIsa:(Class)class {
    
}

- (void)getClassInstanceHash {
    NSString *string1 = @"hello";
    JWPerson *person = [JWPerson new];
    [JWPerson hash];

    NSLog(@"%@ - %zi, %@ - %zi", string1, string1.hash, person, person.hash);
}

- (void)getAllCategory:(Class)class {
    //10.5以后 runtime中删除了objc_category的函数，无法获取到关于类的categorylist的信息。
}

@end
