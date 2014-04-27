//
//  YXYAtomNode.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomNode.h"

@implementation AtomNode

-(id)initWithName:(NSString *)name ImageName:(NSString *)imageName
{
    if(self = [super initWithTexture:[SKTexture textureWithImageNamed:imageName] color:[SKColor colorWithRed:skRandf() green:skRandf() blue:skRandf() alpha:1] size:CGSizeMake(AtomRadius*2, AtomRadius*2)]){
        self.colorBlendFactor = 1.0;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:AtomRadius];
        self.physicsBody.dynamic = YES;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.contactTestBitMask = AtomPlusCategory|AtomMinusCategory|PlayFieldCategory|AtomSharpCategory;
        self.physicsBody.linearDamping = 0.65;
        self.physicsBody.angularDamping = 0.8;
//        The userData property is initially nil. You have to create a dictionary and assign it first
        self.userData = [NSMutableDictionary dictionaryWithDictionary:@{ATOMCOLOR:self.color}];
        self.name = name;
        
    }
    return self;
}



-(void) changeColorWithSameAtom:(AtomNode *) atom
{
    CGFloat red1,green1,blue1,alpha1;
    CGFloat red2,green2,blue2,alpha2;
    CGFloat redtotal,greentotal,bluetotal,alphatotal;
    [[self.userData objectForKey:ATOMCOLOR] getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    [[atom.userData objectForKey:ATOMCOLOR] getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    redtotal = (red1+red2)/2;
    greentotal = (green1+green2)/2;
    bluetotal = (blue1+blue2)/2;
    alphatotal = (alpha1+alpha2)/2;
    
    UIColor *totalColor = [UIColor colorWithRed:redtotal green:greentotal blue:bluetotal alpha:alphatotal];
    [self.userData setObject:totalColor forKey:ATOMCOLOR];
    [atom.userData setObject:totalColor forKey:ATOMCOLOR];
    [self runAction:[SKAction colorizeWithColor:totalColor colorBlendFactor:1 duration:0.5]];
        
    
}
-(void) changeColorWithDiffAtom:(SKSpriteNode *) atom{
    
    [self runAction:[SKAction sequence:@[[SKAction runBlock:^{
        self.physicsBody.velocity = CGVectorMake(0, 0);
        atom.physicsBody.velocity = CGVectorMake(0, 0);
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = 0;

        self.physicsBody = NULL;
    }],
                                         [SKAction colorizeWithColor:[UIColor clearColor] colorBlendFactor:1 duration:0.5],
                                         [SKAction runBlock:^{
        
        [self removeFromParent];
        
    }]]]];
}
@end
