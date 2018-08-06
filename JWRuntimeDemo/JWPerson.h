//
//  JWPerson.h
//  JWRuntimeDemo
//
//  Created by JessieWu on 2018/7/24.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JWPersonProtocol

@required
- (void)firstProtocolFunction;

@optional
- (void)secondProtocolFunction;

@end

typedef NS_ENUM(NSUInteger, JWPersonGenderType) {
    kJWPersonGenderMale = 1 << 1,
    kJWPersonGenderFemale = 1 << 2,
    kJWPersonGenderDescripe = 1 << 3
};

@interface JWPerson : NSObject<NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *cellNum;
@property (nonatomic, assign) JWPersonGenderType gender;

- (void)definedFunction;

@end
