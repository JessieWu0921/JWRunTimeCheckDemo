//
//  JWPerson.m
//  JWRuntimeDemo
//
//  Created by JessieWu on 2018/7/24.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import "JWPerson.h"

@interface JWPerson()

@property (nonatomic, copy) NSString *nameColor;
@property (nonatomic, assign) NSUInteger level;

@end

@implementation JWPerson

- (instancetype)init {
    self = [super init];
    if (self) {
        //
    }
    return self;
}

#pragma mark - method
- (void)definedFunction {
    NSLog(@"%s", __func__);
}

#pragma mark - nscoping
- (instancetype)copyWithZone:(NSZone *)zone {
    JWPerson *person = [[self class] allocWithZone:zone];
    return person;
}


@end
