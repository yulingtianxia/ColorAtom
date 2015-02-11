//
//  Spark.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-19.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "Spark.h"

@implementation Spark
-(instancetype)initWithPosition:(CGPoint) position{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Spark" ofType:@"sks"];
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        self.position = position;
    }
    return self;
}

@end
