//
//  AgainstPlayButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AgainstPlayButton.h"
#import "AgainstPlayScene.h"
@implementation AgainstPlayButton
@synthesize myScene;
-(instancetype)init{
    if (self = [super init]) {
        self.fontName = @"Transformers";
        self.fontSize = 30;
        self.text = NSLocalizedString(@"Against Mode", @"");
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    myScene = [[AgainstPlayScene alloc] initWithSize:self.scene.size];
    [GameKitHelper sharedGameKitHelper].btn = self;
    [[GameKitHelper sharedGameKitHelper] findMatchWithViewController:[UIApplication sharedApplication].keyWindow.rootViewController delegate:myScene];

}
-(void)presentScene{
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    [self.scene.view presentScene:myScene transition: reveal];
}
@end
