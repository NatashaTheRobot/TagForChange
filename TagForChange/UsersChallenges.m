//
//  UsersChallenges.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "UsersChallenges.h"
#import <Parse/PFObject+Subclass.h>

@implementation UsersChallenges

@dynamic user;
@dynamic challenge;
@dynamic status;

+ (NSString *)parseClassName
{
    return @"UsersChallenges";
}

@end
