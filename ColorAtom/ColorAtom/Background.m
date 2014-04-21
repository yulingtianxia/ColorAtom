//
//  Background.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-19.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "Background.h"

@implementation Background
-(id)init{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"BackGround" ofType:@"sks"];
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
    } 
    return self;
}
@end
