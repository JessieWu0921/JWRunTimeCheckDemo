//
//  JWSampleString.m
//  JWRuntimeDemo
//
//  Created by JessieWu on 2018/8/6.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import "JWSampleString.h"

@implementation JWSampleString

#pragma mark - setter & getter
- (NSString *)sampleStringToLoad {
    return _sampleStringToLoad;
}

#pragma mark - methods
- (void)loadingString {
    self.sampleStringToLoad = @"hello world.";
}

@end
