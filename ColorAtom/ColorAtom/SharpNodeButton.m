//
//  SharpNodeButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-27.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "SharpNodeButton.h"
#import "PlayFieldScene.h"

@implementation SharpNodeButton
-(id)init{
    if (self = [super initWithTexture:[SKTexture textureWithImageNamed:@"Atomsharp"] color:[UIColor whiteColor] size:CGSizeMake(40, 40)]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [(PlayFieldScene *)self.scene createAtomSharpByButton:self];
}
@end
