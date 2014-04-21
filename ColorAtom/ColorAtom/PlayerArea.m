//
//  PlayerArea.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "PlayerArea.h"
#import "Define.h"
@implementation PlayerArea
-(void)beginWork{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRect(path, 0, CGRectMake(0, 0, self.scene.size.width, AtomRadius*2));
    self.path = path;
    self.strokeColor = [UIColor clearColor];
    self.lineWidth = 1;
    self.glowWidth = 1;
    self.antialiased = YES;
    self.alpha = 0.8;
    NSString *nodepath = [[NSBundle mainBundle] pathForResource:@"PlayerBackground" ofType:@"sks"];
    SKEmitterNode *background = [NSKeyedUnarchiver unarchiveObjectWithFile:nodepath];
    background.position = CGPointMake(self.scene.size.width/2, AtomRadius);
    [self addChild:background];
    
}
@end
