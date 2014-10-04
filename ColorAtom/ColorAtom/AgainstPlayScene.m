//
//  AgainstPlayScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AgainstPlayScene.h"
#import"YXYAppDelegate.h"
#import "MainScene.h"


@implementation AgainstPlayScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}

#pragma mark override method

-(void)createAtomMinus{
    
}

-(void)sendPosition:(CGPoint)position{
    NSError *error;
    NSData *packet = [NSData dataWithBytes:&position length:sizeof(CGPoint)];
    
    [[GameKitHelper sharedGameKitHelper].match sendDataToAllPlayers: packet withDataMode: GKMatchSendDataUnreliable error:&error];
    if (error != nil)
    {
        // Handle the error.
    }
}

#pragma mark GCHelperDelegate


- (void)matchStarted {
    NSLog(@"Match started");
}

- (void)matchEnded {
    NSLog(@"Match ended");
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    NSLog(@"Received data");
    CGPoint* point = (CGPoint*)[data bytes];
    NSLog(@"receive x:%f y:%f from player:%@",point->x,point->y,playerID);
}

@end
