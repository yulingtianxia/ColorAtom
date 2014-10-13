//
//  Background.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-19.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "Background.h"
#import "GameKitHelper.h"
@implementation Background

-(id)initWithSize:(CGSize) size{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"BackGround" ofType:@"sks"];
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        self.particlePositionRange = CGVectorMake(size.width, size.height);
    } 
    return self;
}

@end
