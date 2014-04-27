//
//  MainSceneButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-27.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "MainSceneButton.h"
#import "MainScene.h"
@implementation MainSceneButton
-(id)init{
    if (self = [super init]) {
        self.fontName = @"Chalkduster";
        self.text = @"MENU";
        self.fontSize = 20;
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene * myScene = [[MainScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:myScene transition: reveal];
}
@end
