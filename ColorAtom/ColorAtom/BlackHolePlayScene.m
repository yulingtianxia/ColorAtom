//
//  BlackHolePlayScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "BlackHolePlayScene.h"

@implementation BlackHolePlayScene
@synthesize secretForce;
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        secretForce = [[BlackHole alloc] init];
        secretForce.position = CGPointMake(CGRectGetMidX(self.frame), 3*self.frame.size.height/4);
        [self addChild:secretForce];
    }
    return self;
}
@end
