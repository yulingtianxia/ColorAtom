//
//  SecretForce.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "SecretForce.h"

@implementation SecretForce
- (instancetype)init{
    if (self=[super init]) {
        self = (SecretForce *)[SKFieldNode noiseFieldWithSmoothness:0.5 animationSpeed:1];
    }
    return self;
}
@end
