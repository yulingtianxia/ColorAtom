//
//  SecretForceScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "SecretPlayScene.h"
#import "SecretForce.h"
@implementation SecretPlayScene
@synthesize secretForce;

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        secretForce = [[SecretForce alloc] init];
        secretForce.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:secretForce];
    }
    return self;
}
@end
