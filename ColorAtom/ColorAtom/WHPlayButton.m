//
//  BHPlayButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "WHPlayButton.h"
#import "WormHolePlayScene.h"
@implementation WHPlayButton
-(id)init{
    if (self = [super init]) {
        self.fontName = @"Transformers";
        self.fontSize = 30;
        self.text = NSLocalizedString(@"WormHole Mode", @"");
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene * myScene = [[WormHolePlayScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:myScene transition: reveal];
}
@end
