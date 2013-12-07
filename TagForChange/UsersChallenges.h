//
//  UsersChallenges.h
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "Challenge.h"

typedef NS_ENUM(NSInteger, ChallengeStatus) {
    ChallengeStatusTagged,
    ChallengeStatusAccepted,
    ChallengeStatusCompleted
};

@interface UsersChallenges : PFObject <PFSubclassing>

@property (strong, nonatomic) TFCUser *user;
@property (strong, nonatomic) Challenge *challenge;
@property (strong, nonatomic) NSNumber *status;

+ (NSString *)parseClassName;

@end
