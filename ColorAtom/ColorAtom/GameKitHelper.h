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
@optional
- (void)onScoresSubmitted:(bool)success;
- (void)matchStarted;
- (void)matchEnded;
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromRemotePlayer:(GKPlayer *)playerID;
- (void)inviteReceived;
@end

@interface GameKitHelper : NSObject

@property (nonatomic, weak) id<GameKitHelperProtocol> delegate;
@property (nonatomic, readonly) NSError* lastError;
@property (nonatomic, strong) UIViewController *presentingViewController;
@property (nonatomic, strong) GKMatch *match;
@property (nonatomic, weak) AgainstPlayButton *btn;
@property (nonatomic, assign) BOOL opponentReady;
@property (nonatomic, strong) GKInvite *pendingInvite;
@property (nonatomic, strong) NSArray *pendingPlayersToInvite;
@property (nonatomic, retain) NSMutableDictionary *achievementsDictionary;

+ (instancetype)sharedGameKitHelper;
@property (NS_NONATOMIC_IOSONLY, getter=getRootViewController, readonly, strong) UIViewController *rootViewController;
- (void)authenticateLocalPlayer;
- (void)submitScore:(int64_t)score identifier:(NSString*)category;
- (BOOL)findMatchWithViewController:(UIViewController *)viewController
                           delegate:(id<GameKitHelperProtocol>)theDelegate;
- (void)sendData:(NSData *)packet withCompleteBlock:(void(^)(void)) block;
- (GKAchievement*)getAchievementForIdentifier: (NSString*)identifier;
- (void)updateAchievement:(GKAchievement*) achievement Identifier: (NSString*) identifier;
- (void)reportMultipleAchievements;
- (void)showLeaderboard;

@end
