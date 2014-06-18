//
//  PlayAgainButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-27.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "PlayAgainButton.h"
#import "Define.h"
#import "PlayFieldScene.h"
#import "NightPlayScene.h"
#import "SecretPlayScene.h"
@implementation PlayAgainButton
@synthesize mode;
-(id)initWithMode:(NSString *)newmode{
    if (self = [super init]) {
        self.fontName = @"Chalkduster";
        self.text = @"PLAY AGAIN";
        self.fontSize = 20;
        self.fontColor = [SKColor whiteColor];
        self.userInteractionEnabled = YES;
        mode = newmode;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([mode isEqualToString:(NSString *)NormalMode]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[PlayFieldScene alloc] initWithSize:self.scene.size];
        [self.scene.view presentScene:myScene transition: reveal];
    }else if ([mode isEqualToString:(NSString *)NightMode]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[NightPlayScene alloc] initWithSize:self.scene.size];
        [self.scene.view presentScene:myScene transition: reveal];
    }else if ([mode isEqualToString:(NSString *)SecretMode]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[SecretPlayScene alloc] initWithSize:self.scene.size];
        [self.scene.view presentScene:myScene transition: reveal];
    }
}
@end
