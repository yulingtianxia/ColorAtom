//
//  GameCenterButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14/10/18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "GameCenterButton.h"

@implementation GameCenterButton

-(instancetype)init{
    if (self = [super initWithTexture:[SKTexture textureWithImageNamed:@"GameCenter"] color:[SKColor clearColor] size:CGSizeMake(40, 40)]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [[GameKitHelper sharedGameKitHelper] showLeaderboard];
}

@end
