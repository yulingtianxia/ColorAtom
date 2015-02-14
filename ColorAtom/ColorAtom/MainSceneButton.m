//
//  MainSceneButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-27.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "MainSceneButton.h"
#import "MainScene.h"
#import "Define.h"

@implementation MainSceneButton
-(instancetype)init{
    if (self = [super init]) {
        self.fontName = FontString;
        self.text = NSLocalizedString(@"MAIN MENU", @"");
        self.fontSize = 20;
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [[GameKitHelper sharedGameKitHelper].match disconnect];
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene * myScene = [[MainScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:myScene transition: reveal];
}
@end
