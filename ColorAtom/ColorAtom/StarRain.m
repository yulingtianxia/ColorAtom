//
//  StarRain.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-5-17.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "StarRain.h"

@implementation StarRain
-(instancetype)init{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"StarRain" ofType:@"sks"];
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
    }
    return self;
}
@end
