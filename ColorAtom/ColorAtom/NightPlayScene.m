//
//  NightPlayScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "NightPlayScene.h"
#import "AtomMinusNode.h"
@implementation NightPlayScene
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}
-(void)createAtomMinus{
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{
        AtomMinusNode *Atom = [[AtomMinusNode alloc] init];
        Atom.color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        Atom.fire.particleColor = Atom.color;
        Atom.position = CGPointMake(skRand(AtomRadius, self.size.width-AtomRadius),self.size.height-AtomRadius);
        
        [self addChild:Atom];
    }],
                                                                       [SKAction waitForDuration:AtomMinusCreateInterval/self.rank withRange:0.5/self.rank]]]]];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{
        for (int i=0; i<self.rank; i++) {
            AtomMinusNode *Atom = [[AtomMinusNode alloc] init];
            Atom.color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
            Atom.fire.particleColor = Atom.color;
            Atom.position = CGPointMake(skRand(AtomRadius, self.size.width-AtomRadius),self.size.height-AtomRadius);
            
            [self addChild:Atom];
        }
        
    }],
                                                                       [SKAction waitForDuration:AtomMinusCreateInterval*self.rank*10]]]]];
}
@end
