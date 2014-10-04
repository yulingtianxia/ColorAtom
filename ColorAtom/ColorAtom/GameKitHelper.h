//
//  GameKitHelper.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-9-12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AgainstPlayButton;
@import GameKit;

@protocol GameKitHelperProtocol<NSObject>
-(void) onScoresSubmitted:(bool)success;
- (void)matchStarted;
- (void)matchEnded;
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data
   fromPlayer:(NSString *)playerID;
@end

@interface GameKitHelper : NSObject

@property (nonatomic,assign) id<GameKitHelperProtocol> delegate;
@property (nonatomic, readonly) NSError* lastError;
@property (retain) UIViewController *presentingViewController;
@property (retain) GKMatch *match;
@property (retain) AgainstPlayButton *btn;

+ (instancetype) sharedGameKitHelper;
-(void) authenticateLocalPlayer;
-(void) submitScore:(int64_t)score identifier:(NSString*)category;
- (void)findMatchWithViewController:(UIViewController *)viewController
                           delegate:(id<GameKitHelperProtocol>)theDelegate;
@end
