//
//  AgainstResult.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AgainstResult.h"
#import "PlayAgainButton.h"
#import "WeiboShareButton.h"
#import "MainSceneButton.h"
#import "Define.h"
#import "Background.h"
#import "GameConstants.h"
#import "AgainstPlayScene.h"

@implementation AgainstResult
@synthesize background;
@synthesize sharingText;
@synthesize sharingImage;
@synthesize win;
@synthesize playAgain;
- (instancetype)initWithSize:(CGSize)size  win:(BOOL)isWin{
    if (self = [super initWithSize:size]) {
        [GameKitHelper sharedGameKitHelper].delegate = self;
        [GameKitHelper sharedGameKitHelper].opponentReady = NO;
        NSString *opponentName = ((GKPlayer *)[GameKitHelper sharedGameKitHelper].match.players[0]).displayName;
        win = isWin;
        if (win) {
            sharingText = [NSString localizedStringWithFormat:NSLocalizedString(@"I just defeated %@ in ColorAtom!", @""),opponentName];
        }
        else{
            sharingText = [NSString localizedStringWithFormat:NSLocalizedString(@"I was defeated by %@ in ColorAtom!", @""),opponentName];
        }
        self.backgroundColor = [SKColor clearColor];
//        背景效果
        background = [[Background alloc] initWithSize:size];
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
        SKLabelNode *modeLabel = [SKLabelNode labelNodeWithFontNamed:FontString];
        modeLabel.text = NSLocalizedString((NSString *)AgainstMode, @"") ;
        modeLabel.fontSize = 40;
        modeLabel.fontColor = [SKColor purpleColor];
        modeLabel.position = CGPointMake(self.size.width/2, 3*self.frame.size.height/4+modeLabel.frame.size.height);
        [self addChild:modeLabel];
        
        SKLabelNode *winLabel = [SKLabelNode labelNodeWithFontNamed:FontString];
        if (win) {
            winLabel.text = NSLocalizedString(@"WIN", @"");
        }
        else{
            winLabel.text = NSLocalizedString(@"LOSE", @"");
        }
        winLabel.fontSize = 40;
        winLabel.fontColor = [SKColor purpleColor];
        winLabel.position = CGPointMake(self.size.width/2, 3*self.frame.size.height/4);
        [self addChild:winLabel];
        
        SKLabelNode *playerLabel = [SKLabelNode labelNodeWithFontNamed:FontString];
        playerLabel.text = NSLocalizedString(@"Opponent Name:", @"");
        playerLabel.fontSize = 30;
        playerLabel.fontColor = [SKColor greenColor];
        playerLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(winLabel.frame)-playerLabel.frame.size.height);
        [self addChild:playerLabel];
        
        SKLabelNode *nameLabel = [SKLabelNode labelNodeWithFontNamed:FontString];
        NSString *playerName = opponentName;
        nameLabel.text = playerName;
        nameLabel.fontSize = 30;
        nameLabel.fontColor = [SKColor greenColor];
        nameLabel.position = CGPointMake(self.size.width/2, CGRectGetMinY(playerLabel.frame)-nameLabel.frame.size.height);
        [self addChild:nameLabel];
        
        playAgain = [[PlayAgainButton alloc] initWithMode:(NSString *)AgainstMode];
        playAgain.position = CGPointMake(self.size.width/2, self.size.height/3);
        [self addChild:playAgain];
        
        WeiboShareButton *weiboShare = [[WeiboShareButton alloc] init];
        weiboShare.position = CGPointMake(self.size.width/2, CGRectGetMinY(playAgain.frame)-2*playAgain.frame.size.height);
        [self addChild:weiboShare];
        
        MainSceneButton *mainScene = [[MainSceneButton alloc] init];
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

#pragma mark GCHelperDelegate

-(void)inviteReceived{
    
}

- (void)matchStarted {
//    NSLog(@"Match started");
}

- (void)matchEnded {
//    NSLog(@"Match ended");
    NSString *title = NSLocalizedString(@"GameOver", @"");
    NSString *message = NSLocalizedString(@"Connection lost", @"");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        playAgain.alpha = 0.2;
        [playAgain setUserInteractionEnabled:FALSE];
    }];
    [alert addAction:ok];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    //    NSLog(@"Received data");
    Message *message = (Message *) data.bytes;
    if (message->messageType == kMessageTypeReplayRequest) {
        NSString *title = NSLocalizedString(@"Play Again?", @"");
        NSString *message = NSLocalizedString(@"Your opponent wants to play with you again", @"");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            MessageReplayResponse response;
            response.message.messageType = kMessageTypeReplayResponse;
            response.agree = YES;
            NSData *packet = [NSData dataWithBytes:&response length:sizeof(MessageReplayResponse)];
            [[GameKitHelper sharedGameKitHelper] sendData:packet withCompleteBlock:^{
                SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
                AgainstPlayScene * gameOverScene = [[AgainstPlayScene alloc] initWithSize:self.size];
                [GameKitHelper sharedGameKitHelper].delegate = gameOverScene;
                [self.scene.view presentScene:gameOverScene transition: reveal];
            }];
            
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Refuse", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

            MessageReplayResponse response;
            response.message.messageType = kMessageTypeReplayResponse;
            response.agree = NO;
            NSData *packet = [NSData dataWithBytes:&response length:sizeof(MessageReplayResponse)];
            [[GameKitHelper sharedGameKitHelper] sendData:packet withCompleteBlock:^{
                [[GameKitHelper sharedGameKitHelper].match disconnect];
            }];
            
            
        }];
        [alert addAction:ok];
        [alert addAction:cancel];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }
    else if (message->messageType == kMessageTypeReplayResponse) {
        MessageReplayResponse *response = (MessageReplayResponse *)data.bytes;
        if (!(*response).agree) {
            NSString *title = NSLocalizedString(@"Sorry", @"");
            NSString *message = NSLocalizedString(@"Your opponent has refused your request", @"");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                playAgain.alpha = 0.2;
                [playAgain setUserInteractionEnabled:FALSE];
            }];
            [alert addAction:ok];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        }
        else{
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            AgainstPlayScene * gameOverScene = [[AgainstPlayScene alloc] initWithSize:self.size];
            [GameKitHelper sharedGameKitHelper].delegate = gameOverScene;
            [self.scene.view presentScene:gameOverScene transition: reveal];
        }
    }
    else {
        MessageGameOver mg;
        mg.message.messageType = kMessageTypeGameOver;
        NSData *packet = [NSData dataWithBytes:&mg length:sizeof(MessageGameOver)];
        [[GameKitHelper sharedGameKitHelper] sendData:packet withCompleteBlock:nil];
    }
    
    
}
@end
