//
//  DisplayScreen.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-19.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "DisplayScreen.h"
#import "Define.h"
#import "GameOverScene.h"
#import "PlayFieldScene.h"
#import <objc/runtime.h>
@implementation DisplayScreen
@synthesize atomCount;
@synthesize score;
@synthesize rank;
@synthesize sharp;
@synthesize atomCountLabel;
@synthesize scoreLabel;
@synthesize rankLabel;
@synthesize atomIcon;
-(id)init{
    if (self = [super init]) {
        self.name = (NSString *)DisplayScreenName;
        atomCount = 10;
        score = 0;
        sharp = 1;
        rank = 1;
        atomCountLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        atomCountLabel.fontSize = 20;
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        scoreLabel.fontSize = 20;
        rankLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        rankLabel.fontSize = 20;
        atomCountLabel.text = [NSString stringWithFormat:@"%ld",(long)atomCount];
        scoreLabel.text = [NSString stringWithFormat:@"Score:%ld/%ld",(long)score,(long)(((PlayFieldScene *)self.scene).updateScore)];
        rankLabel.text = [NSString stringWithFormat:@"Rank:%ld",(long)rank];
        [self addChild:atomCountLabel];
        [self addChild:scoreLabel];
        [self addChild:rankLabel];
        
        atomIcon = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"Atomplus"]];
        atomIcon.size = CGSizeMake(20, 20);
        [self addChild:atomIcon];
    }
    return self;
    
}
-(void)setPosition{
    self.size = CGSizeMake(self.scene.size.width, self.scene.size.height-AtomRadius*2);
    self.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2+AtomRadius);
    atomCountLabel.position = CGPointMake(-self.size.width/2+atomCountLabel.frame.size.width/2+atomIcon.size.width, -self.size.height/2+atomCountLabel.frame.size.height/2);
    scoreLabel.position = CGPointMake(0, self.size.height/2-scoreLabel.frame.size.height);
    rankLabel.position = CGPointMake(self.size.width/2-rankLabel.frame.size.width/2, -self.size.height/2+rankLabel.frame.size.height/2);
    atomIcon.position = CGPointMake(-self.size.width/2+atomIcon.size.width/2, -self.size.height/2+3*atomIcon.size.height/4);
    

}
-(void)AtomMinusKilled{
    atomCount+=3;
    score+=10;
    atomCountLabel.text = [NSString stringWithFormat:@"%ld",(long)atomCount];
    scoreLabel.text = [NSString stringWithFormat:@"Score:%ld/%ld",(long)score,(long)(((PlayFieldScene *)self.scene).updateScore)];
    rankLabel.text = [NSString stringWithFormat:@"Rank:%ld",(long)rank];
    [self gameCheck];
    [self setPosition];
}

-(void)AtomPlusUsed:(NSInteger) num{
    atomCount-=num;
    score+=5*num;
    atomCountLabel.text = [NSString stringWithFormat:@"%ld",(long)atomCount];
    scoreLabel.text = [NSString stringWithFormat:@"Score:%ld/%ld",(long)score,(long)(((PlayFieldScene *)self.scene).updateScore)];
    rankLabel.text = [NSString stringWithFormat:@"Rank:%ld",(long)rank];
    [self gameCheck];
    [self setPosition];
}

-(void)AtomMinusAttacked{
    atomCount-=10*rank;
    atomCountLabel.text = [NSString stringWithFormat:@"%ld",(long)atomCount];
    [self gameCheck];
    [self setPosition];
}

-(void)gameCheck{
    if (atomCount<=0) {
        NSString *bodyClassName = [NSString stringWithUTF8String:class_getName(self.scene.class)];
        NSString *mode;
        if ([bodyClassName isEqualToString:@"PlayFieldScene"]) {
            mode = (NSString *)NormalMode;
        }
        else if ([bodyClassName isEqualToString:@"NightPlayScene"]){
            mode = (NSString *)NightMode;
        }
        else if ([bodyClassName isEqualToString:@"SecretPlayScene"]){
            mode = (NSString *)SecretMode;
        }
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.scene.size score:score mode:mode];
        [self.scene.view presentScene:gameOverScene transition: reveal];
    }
}
@end
