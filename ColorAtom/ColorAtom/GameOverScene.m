//
//  YXYGameOverScene.m
//  MyFirstGame
//
//  Created by 杨萧玉 on 14-3-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "GameOverScene.h"
#import "PlayFieldScene.h"
#import "PlayAgainButton.h"
#import "WeiboShareButton.h"
#import "MainSceneButton.h"
#import "GameKitHelper.h"
#import "GameConstants.h"
@implementation GameOverScene
@synthesize background;
@synthesize score;
@synthesize sharingText;
@synthesize sharingImage;
@synthesize mode;
-(id)initWithSize:(CGSize)size score:(NSInteger) newscore mode:(NSString *)newmode{
    if (self = [super initWithSize:size]) {
        score = newscore;
        mode = newmode;
        sharingText = [NSString stringWithFormat:@"我在ColorAtom的%@中得了%ld分，快来超越我吧！ http://yulingtianxia.com/ColorAtom/",mode,(long)score];
        self.backgroundColor = [SKColor clearColor];
//        背景效果
        background = [[Background alloc] init];
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
//        各种label
        SKLabelNode *modeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *gameover = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *newScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *newScoreNumLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *highScoreNumLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        PlayAgainButton *playAgain = [[PlayAgainButton alloc] initWithMode:mode];
        WeiboShareButton *weiboShare = [[WeiboShareButton alloc] init];
        MainSceneButton *mainScene = [[MainSceneButton alloc] init];
        modeLabel.text = mode;
        modeLabel.fontSize = 40;
        modeLabel.fontColor = [SKColor purpleColor];
        modeLabel.position = CGPointMake(self.size.width/2, 3*self.frame.size.height/4+modeLabel.frame.size.height);
        [self addChild:modeLabel];
        gameover.text = @"GAME OVER";
        gameover.fontSize = 40;
        gameover.fontColor = [SKColor purpleColor];
        gameover.position = CGPointMake(self.size.width/2, 3*self.frame.size.height/4);
        [self addChild:gameover];
        newScoreLabel.text = @"NEWSCORE";
        newScoreLabel.fontSize = 35;
        newScoreLabel.fontColor = [SKColor greenColor];
        newScoreLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(gameover.frame)-newScoreLabel.frame.size.height);
        [self addChild:newScoreLabel];
        newScoreNumLabel.text = [NSString stringWithFormat:@"%ld",(long)score];
        newScoreNumLabel.fontSize = 35;
        newScoreNumLabel.fontColor = [SKColor greenColor];
        newScoreNumLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(newScoreLabel.frame)-newScoreNumLabel.frame.size.height);
        [self addChild:newScoreNumLabel];
        highScoreLabel.text = @"HIGHSCORE";
        highScoreLabel.fontSize = 35;
        highScoreLabel.fontColor = [SKColor redColor];
        highScoreLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(newScoreNumLabel.frame)-highScoreLabel.frame.size.height);
        [self addChild:highScoreLabel];
        highScoreNumLabel.text =  [NSString stringWithFormat:@"%ld",(long)[self setHighScore]];
        highScoreNumLabel.fontSize = 35;
        highScoreNumLabel.fontColor = [SKColor redColor];
        highScoreNumLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(highScoreLabel.frame)-highScoreNumLabel.frame.size.height);
        [self addChild:highScoreNumLabel];
        playAgain.position = CGPointMake(self.size.width/2, self.size.height/3);
        [self addChild:playAgain];
        
        weiboShare.position = CGPointMake(self.size.width/2, CGRectGetMinY(playAgain.frame)-2*playAgain.frame.size.height);
        [self addChild:weiboShare];
        
        mainScene.position = CGPointMake(self.size.width/2, CGRectGetMinY(weiboShare.frame)-2*weiboShare.frame.size.height);
        [self addChild:mainScene];
    }
    return self;
}

#pragma mark MyMethod
- (UIImage*) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


- (UIImage*) imageFromNode:(SKNode*)node
{
    SKTexture*      tex     = [self.scene.view textureFromNode:node];
    SKView*         view    = [[SKView alloc]initWithFrame:CGRectMake(0, 0, tex.size.width, tex.size.height)];
    SKScene*        scene   = [SKScene sceneWithSize:tex.size];
    SKSpriteNode*   sprite  = [SKSpriteNode spriteNodeWithTexture:tex];
    sprite.position = CGPointMake( CGRectGetMidX(view.frame), CGRectGetMidY(view.frame) );
    [scene addChild:sprite];
    [view presentScene:scene];
    
    return [self imageWithView:view];
}
-(NSInteger)setHighScore{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger highScore = [standardDefaults integerForKey:mode];
    if (score > highScore) {
        [standardDefaults setInteger:score forKey:mode];
        [standardDefaults synchronize];
        //sent high score to gamecenter
        [[GameKitHelper sharedGameKitHelper] submitScore:score identifier:kHighScoreLeaderboardIdentifier];
        return score;
    }
    return highScore;
}
@end
