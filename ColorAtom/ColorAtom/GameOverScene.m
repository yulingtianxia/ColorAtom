//
//  YXYGameOverScene.m
//  MyFirstGame
//
//  Created by 杨萧玉 on 14-3-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "GameOverScene.h"
#import "PlayFieldScene.h"
#import "Weibo.h"

@implementation GameOverScene
@synthesize background;
@synthesize score;
@synthesize shareText;
-(id)initWithSize:(CGSize)size Score:(NSInteger) newscore{
    if (self = [super initWithSize:size]) {
        score = newscore;
        shareText = [NSString stringWithFormat:@"我在ColorAtom中得了%ld分，快来超越我吧！",score];
        self.backgroundColor = [SKColor clearColor];
//        背景效果
        background = [[Background alloc] init];
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
//        各种label
        SKLabelNode *gameover = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *newScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *newScoreNumLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *highScoreNumLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *playAgain = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *weiboShare = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        gameover.text = @"GAME OVER";
        gameover.fontSize = 40;
        gameover.fontColor = [SKColor whiteColor];
        gameover.position = CGPointMake(self.size.width/2, 3*self.frame.size.height/4);
        [self addChild:gameover];
        newScoreLabel.text = @"NEWSCORE";
        newScoreLabel.fontSize = 35;
        newScoreLabel.fontColor = [SKColor whiteColor];
        newScoreLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(gameover.frame)-newScoreLabel.frame.size.height);
        [self addChild:newScoreLabel];
        newScoreNumLabel.text = [NSString stringWithFormat:@"%ld",(long)score];
        newScoreNumLabel.fontSize = 35;
        newScoreNumLabel.fontColor = [SKColor whiteColor];
        newScoreNumLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(newScoreLabel.frame)-newScoreNumLabel.frame.size.height);
        [self addChild:newScoreNumLabel];
        highScoreLabel.text = @"HIGHSCORE";
        highScoreLabel.fontSize = 35;
        highScoreLabel.fontColor = [SKColor whiteColor];
        highScoreLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(newScoreNumLabel.frame)-highScoreLabel.frame.size.height);
        [self addChild:highScoreLabel];
        highScoreNumLabel.text =  [NSString stringWithFormat:@"%ld",(long)[self setNewScore]];
        highScoreNumLabel.fontSize = 35;
        highScoreNumLabel.fontColor = [SKColor whiteColor];
        highScoreNumLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(highScoreLabel.frame)-highScoreNumLabel.frame.size.height);
        [self addChild:highScoreNumLabel];
        playAgain.text = @"PLAY AGAIN";
        playAgain.name = @"playagain";
        playAgain.fontSize = 20;
        playAgain.fontColor = [SKColor whiteColor];
        playAgain.position = CGPointMake(self.size.width/2, self.size.height/4);
        [self addChild:playAgain];
        weiboShare.text = @"SHARE SCORE";
        weiboShare.name = @"weiboshare";
        weiboShare.fontSize = 20;
        weiboShare.position = CGPointMake(self.size.width/2, self.size.height/8);
        [self addChild:weiboShare];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
//    SKLabelNode *touchedNode = (SKLabelNode *)[self nodeAtPoint:location];
//    if ([touchedNode.name isEqualToString:@"playagain"]) {
//        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
//        SKScene * myScene = [[PlayFieldScene alloc] initWithSize:self.size];
//        [self.view presentScene:myScene transition: reveal];
//    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKLabelNode *touchedNode = (SKLabelNode *)[self nodeAtPoint:location];
    if ([touchedNode.name isEqualToString:@"playagain"]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[PlayFieldScene alloc] initWithSize:self.size];
        [self.view presentScene:myScene transition: reveal];
    }else if ([touchedNode.name isEqualToString:@"weiboshare"]){
        Weibo *weibo = [[Weibo alloc] initWithAppKey:WEIBO_APP_KEY withAppSecret:WEIBO_APP_SECRET];
        [Weibo setWeibo:weibo];
        // Override point for customization after application launch.
        
        if (weibo.isAuthenticated) {
            [weibo newStatus:shareText pic:nil completed:^(Status *status, NSError *error) {
                if (error) {
                    NSLog(@"failed to post:%@", error);
                    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"悲剧" message:@"微博发送失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [av setAlertViewStyle:UIAlertViewStyleDefault];
                    [av show];
                }
                else {
                    NSLog(@"success: %lld.%@", status.statusId, status.text);
                    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"微博发送成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [av setAlertViewStyle:UIAlertViewStyleDefault];
                    [av show];
                }
            }];
        }else{
            [Weibo.weibo authorizeWithCompleted:^(WeiboAccount *account, NSError *error) {
                if (!error) {
                    NSLog(@"Sign in successful: %@", account.user.screenName);
                    [weibo newStatus:shareText pic:nil completed:^(Status *status, NSError *error) {
                        if (error) {
                            NSLog(@"failed to post:%@", error);
                            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"悲剧" message:@"微博发送失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                            [av setAlertViewStyle:UIAlertViewStyleDefault];
                            [av show];
                        }
                        else {
                            NSLog(@"success: %lld.%@", status.statusId, status.text);
                            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"微博发送成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                            [av setAlertViewStyle:UIAlertViewStyleDefault];
                            [av show];
                        }
                    }];
                }
                else {
                    NSLog(@"Failed to sign in: %@", error);
                    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"悲剧" message:@"微博登录失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [av setAlertViewStyle:UIAlertViewStyleDefault];
                    [av show];
                    
                }
            }];
        }
    }
}

-(NSInteger)setNewScore{
    NSNumber *newScore = [NSNumber numberWithInteger:score];
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults registerDefaults:@{@"highscore": newScore}];
    [standardDefaults synchronize];
    NSNumber *highScore = [standardDefaults objectForKey:@"highscore"];
    if ([newScore compare:highScore]==NSOrderedDescending) {
        [standardDefaults setObject:newScore forKey:@"highscore"];
        [standardDefaults synchronize];
        return score;
    }
    return [highScore integerValue];
}
@end
