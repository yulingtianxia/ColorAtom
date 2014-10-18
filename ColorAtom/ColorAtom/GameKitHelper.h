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
- (void)inviteReceived;
@end

@interface GameKitHelper : NSObject

@property (nonatomic,weak) id<GameKitHelperProtocol> delegate;
@property (nonatomic, readonly) NSError* lastError;
@property (strong) UIViewController *presentingViewController;
@property (strong) GKMatch *match;
@property (weak) AgainstPlayButton *btn;
@property BOOL opponentReady;
@property (strong) GKInvite *pendingInvite;
@property (strong) NSArray *pendingPlayersToInvite;
@property(nonatomic, retain) NSMutableDictionary *achievementsDictionary;

+ (instancetype) sharedGameKitHelper;
-(UIViewController*) getRootViewController;
-(void) authenticateLocalPlayer;
-(void) submitScore:(int64_t)score identifier:(NSString*)category;
- (void)findMatchWithViewController:(UIViewController *)viewController
                           delegate:(id<GameKitHelperProtocol>)theDelegate;
-(void)sendData:(NSData *)packet withCompleteBlock:(void(^)(void)) block;
- (GKAchievement*) getAchievementForIdentifier: (NSString*) identifier;
- (void) updateAchievement:(GKAchievement*) achievement Identifier: (NSString*) identifier;
- (void) reportMultipleAchievements;
- (void) showLeaderboard;

@end
