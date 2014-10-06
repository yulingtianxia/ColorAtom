//
//  AgainstPlayScene.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "PlayFieldScene.h"

@interface AgainstPlayScene : PlayFieldScene <GameKitHelperProtocol>
@property BOOL playerReady;
@property BOOL gameReady;
@end
