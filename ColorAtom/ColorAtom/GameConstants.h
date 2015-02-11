//
//  GameConstants.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-9-14.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#ifndef ColorAtom_GameConstants_h
#define ColorAtom_GameConstants_h
#define kHighScoreLeaderboardIdentifier @"com.yulingtianxia.ColorAtom.HighScores"
#define kNormalHighScoreLeaderboardIdentifier @"com.yulingtianxia.ColorAtom.NormalHighScores"
#define kNightHighScoreLeaderboardIdentifier @"com.yulingtianxia.ColorAtom.NightHighScores"
#define kSecretHighScoreLeaderboardIdentifier @"com.yulingtianxia.ColorAtom.SecretHighScores"
#define kWormHoleHighScoreLeaderboardIdentifier @"com.yulingtianxia.ColorAtom.WormHoleHighScores"

#define kget100PointsAchievementID @"com.yulingtianxia.ColorAtom.get100"
#define kget300PointsAchievementID @"com.yulingtianxia.ColorAtom.get300"
#define kget500PointsAchievementID @"com.yulingtianxia.ColorAtom.get500"
#define kget1KPointsAchievementID @"com.yulingtianxia.ColorAtom.get1000"
#define kget2KPointsAchievementID @"com.yulingtianxia.ColorAtom.get2000"
#define kget4KPointsAchievementID @"com.yulingtianxia.ColorAtom.get4000"
#define kget8KPointsAchievementID @"com.yulingtianxia.ColorAtom.get8000"
typedef NS_ENUM(unsigned int, MessageType) {
    kMessageTypeGameBeginRequest = 0,
    kMessageTypeGameBeginResponse,
    kMessageTypePosition,
    kMessageTypeGameOver,
    kMessageTypeReplayRequest,
    kMessageTypeReplayResponse
};
typedef struct {
    MessageType messageType;
} Message;
typedef struct {
    Message message;
} MessageGameBeginRequest;
typedef struct {
    Message message;
} MessageGameBeginResponse;
typedef struct {
    Message message;
//    BOOL player1Won;
} MessageGameOver;
typedef struct {
    Message message;
    CGPoint position;
} MessagePosition;
typedef struct {
    Message message;
    
} MessageReplayRequest;
typedef struct {
    Message message;
    BOOL agree;
} MessageReplayResponse;
#endif
