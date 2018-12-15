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
#import "GameConstants.h"
#import "AgainstResult.h"

@implementation DisplayScreen

- (instancetype)initWithAtomCount:(NSInteger) count{
    if (self = [super init]) {
        self.name = (NSString *)DisplayScreenName;
        self.atomCount = count;
        self.score = 0;
        self.sharp = 1;
        self.rank = 1;
        self.atomCountLabel = [SKLabelNode labelNodeWithFontNamed:FontString];
        self.atomCountLabel.fontSize = 20;
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:FontString];
        self.scoreLabel.fontSize = 20;
        self.rankLabel = [SKLabelNode labelNodeWithFontNamed:FontString];
        self.rankLabel.fontSize = 20;
        self.pauseLabel = [SKLabelNode labelNodeWithFontNamed:FontString];
        self.pauseLabel.fontSize = 40;
        self.pauseLabel.alpha = 0;
        self.atomCountLabel.text = [NSString stringWithFormat:@"%ld",(long)self.atomCount];
        self.scoreLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Score:%ld/%ld", @"") ,(long)self.score,(long)(((PlayFieldScene *)self.scene).updateScore)];
        self.rankLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Rank:%ld", @""),(long)self.rank];
        self.pauseLabel.text = NSLocalizedString(@"PAUSE", @"");
        [self addChild:self.atomCountLabel];
        [self addChild:self.scoreLabel];
        [self addChild:self.rankLabel];
        [self addChild:self.pauseLabel];
        self.atomIcon = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"Atomplus"]];
        self.atomIcon.size = CGSizeMake(20, 20);
        [self addChild:self.atomIcon];
    }
    return self;
    
}
-(void)setPosition{
    self.size = CGSizeMake(self.scene.size.width, self.scene.size.height-AtomRadius*2);
    self.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2+AtomRadius);
    self.atomCountLabel.position = CGPointMake(-self.size.width/2+self.atomCountLabel.frame.size.width/2+self.atomIcon.size.width, -self.size.height/2+self.atomCountLabel.frame.size.height/2);
    self.scoreLabel.position = CGPointMake(0, self.size.height/2-self.scoreLabel.frame.size.height);
    self.rankLabel.position = CGPointMake(self.size.width/2-self.rankLabel.frame.size.width/2, -self.size.height/2+self.rankLabel.frame.size.height/2);
    self.atomIcon.position = CGPointMake(-self.size.width/2+self.atomIcon.size.width/2, -self.size.height/2+3*self.atomIcon.size.height/4);
    self.pauseLabel.position = CGPointMake(0, 0);

}
-(void)AtomMinusKilled{
    self.atomCount+=3;
    self.score+=10;
    self.atomCountLabel.text = [NSString stringWithFormat:@"%ld",(long)self.atomCount];
    self.scoreLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Score:%ld/%ld", @""),(long)self.score,(long)(((PlayFieldScene *)self.scene).updateScore)];
    self.rankLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Rank:%ld", @""),(long)self.rank];
    [self gameCheck];
    [self setPosition];
}

-(void)AtomPlusUsed:(NSInteger) num{
    self.atomCount-=num;
    self.score+=5*num;
    self.atomCountLabel.text = [NSString stringWithFormat:@"%ld",(long)self.atomCount];
    self.scoreLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Score:%ld/%ld", @""),(long)self.score,(long)(((PlayFieldScene *)self.scene).updateScore)];
    self.rankLabel.text = [NSString localizedStringWithFormat:NSLocalizedString(@"Rank:%ld", @""),(long)self.rank];
    [self gameCheck];
    [self setPosition];
}

-(void)AtomMinusAttacked{
    self.atomCount-=10*self.rank;
    self.atomCountLabel.text = [NSString stringWithFormat:@"%ld",(long)self.atomCount];
    [self gameCheck];
    [self setPosition];
}

-(void)gameCheck{
    if (self.atomCount<=0) {
        NSString *bodyClassName = @(class_getName(self.scene.class));
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        NSString *modeString = [standardDefaults objectForKey:@"mode"][bodyClassName];
        if ([modeString isEqualToString: (NSString *)AgainstMode]) {
            MessageGameOver mg;
            mg.message.messageType = kMessageTypeGameOver;
            NSData *packet = [NSData dataWithBytes:&mg length:sizeof(MessageGameOver)];
            [[GameKitHelper sharedGameKitHelper] sendData:packet withCompleteBlock:^{
                SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
                SKScene * gameOverScene = [[AgainstResult alloc] initWithSize:self.scene.size win:NO];
                [self.scene.view presentScene:gameOverScene transition: reveal];
            }];
            
        }
        else {
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.scene.size score:self.score mode:modeString];
            [self.scene.view presentScene:gameOverScene transition: reveal];
        }
        
    }
}

-(void)pause{
    self.pauseLabel.alpha = 1;
    [((PlayFieldScene *)self.scene) hideGame];
}

-(void)resume{
    self.pauseLabel.alpha = 0;
    [((PlayFieldScene *)self.scene) showGame];
}
@end
