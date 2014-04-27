//
//  AtomSharp.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomSharpNode.h"
#import "Define.h"
#import "NodeCategories.h"
#import "AtomPlusNode.h"
@implementation AtomSharpNode
@synthesize magic;
-(id)init{
    if (self=[super initWithTexture:[SKTexture textureWithImageNamed:@"Atomsharp"] color:[UIColor whiteColor] size:CGSizeMake(AtomRadius*4, AtomRadius*4)]) {
        self.colorBlendFactor = 1.0;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:AtomRadius*2];
        self.physicsBody.dynamic = YES;
        self.physicsBody.categoryBitMask = AtomSharpCategory;
        self.physicsBody.contactTestBitMask = AtomPlusCategory|AtomMinusCategory|PlayFieldCategory|AtomSharpCategory;
        self.physicsBody.collisionBitMask = AtomSharpCategory|PlayFieldCategory;
        self.physicsBody.linearDamping = 0.7;
        self.physicsBody.angularDamping = 0.8;
        self.physicsBody.velocity = CGVectorMake(AtomSharpVx, AtomSharpVy);
        self.name = (NSString *)AtomSharpName;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SharpMagic" ofType:@"sks"];
        magic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        magic.position = self.position;
        [self addChild:magic];
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        if ([[standardDefaults stringForKey:@"audio"] isEqualToString:@"on"]){
            [self runAction:[SKAction playSoundFileNamed:@"sharp.mp3" waitForCompletion:NO]];
        }
        
    }
    return  self;
}

-(void)destroy{
    AtomNode *Atom1 = [[AtomPlusNode alloc] init];
    AtomNode *Atom2 = [[AtomPlusNode alloc] init];
    AtomNode *Atom3 = [[AtomPlusNode alloc] init];
    AtomNode *Atom4 = [[AtomPlusNode alloc] init];
    
    CGFloat velocity = 100;
    Atom1.physicsBody.velocity = CGVectorMake(velocity, velocity);
    Atom2.physicsBody.velocity = CGVectorMake(velocity, -velocity);
    Atom3.physicsBody.velocity = CGVectorMake(-velocity, -velocity);
    Atom4.physicsBody.velocity = CGVectorMake(-velocity, velocity);
    
    [self.parent addChild:Atom1];
    [self.parent addChild:Atom2];
    [self.parent addChild:Atom3];
    [self.parent addChild:Atom4];
    Atom1.position = CGPointMake(self.position.x+(AtomRadius+10),self.position.y+(AtomRadius+10));
    Atom2.position = CGPointMake(self.position.x+(AtomRadius+10),self.position.y-(AtomRadius+10));
    Atom3.position = CGPointMake(self.position.x-(AtomRadius+10),self.position.y-(AtomRadius+10));
    Atom4.position = CGPointMake(self.position.x-(AtomRadius+10),self.position.y+(AtomRadius+10));
    
    [self runAction:[SKAction sequence:@[[SKAction runBlock:^{
        self.physicsBody.velocity = CGVectorMake(0, 0);
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
