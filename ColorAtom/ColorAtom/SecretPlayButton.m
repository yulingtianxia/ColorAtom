//
//  SecretPlayButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "SecretPlayButton.h"
#import "SecretPlayScene.h"
#import "Define.h"

@implementation SecretPlayButton
-(instancetype)init{
    if (self = [super init]) {
        self.fontName = FontString;
        self.fontSize = 30;
        self.text = NSLocalizedString(@"Secret Mode", @"");
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene * myScene = [[SecretPlayScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:myScene transition: reveal];
}
@end
