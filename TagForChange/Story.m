//
//  Story.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "Story.h"
#import <Parse/PFObject+Subclass.h>

@implementation Story

@dynamic storyType;
@dynamic challenge;
@dynamic primaryUser;
@dynamic secondaryUser;
@dynamic likes;

+ (NSString *)parseClassName
{
    return @"Story";
}

//{USER_A} = Me
//{USER_B} = friend/someone else
//
//
//Created a challenge (with title)
//Text: {USER_B} created a challenge to {TITLE_OF_CHALLENGE}.
//
//Joined a challenge
//Text: {USER_B} joined {TITLE_OF_CHALLENGE} challenge!
//
//USER_B Accepted a tag challenge
//Text: {USER_B} accepted the {TITLE_OF_CHALLENGE} challenge!
//
//Took an action
//Text: {USER_B} took an action for the {TITLE_OF_CHALLENGE} challenge
//
//Tagged someone else in a challenge
//{USER_A} tagged {USER_B} in the {TITLE_OF_CHALLENGE} challenge!

//typedef NS_ENUM(NSInteger, StoryType) {
//    StoryTypeChallengeCreated,
//    StoryTypeChallengeJoined,
//    StoryTypeChallengeAccepted,
//    StoryTypeChallengeCompleted,
//    StoryTypeChallengeTagged
//};

- (NSString *)text
{
    NSString *text;
    
    [self.challenge fetchIfNeeded];
    [self.primaryUser fetchIfNeeded];
    [self.secondaryUser fetchIfNeeded];
    
    switch (self.storyType.integerValue) {
        case StoryTypeChallengeCreated:
            text = [NSString stringWithFormat:@"@%@ created a challege to %@!", self.primaryUser.username, self.challenge.title];
            break;
        case StoryTypeChallengeJoined:
            text = [NSString stringWithFormat:@"@%@ joined the %@ challenge!", self.primaryUser.username, self.challenge.title];
            break;
        case StoryTypeChallengeAccepted:
            text = [NSString stringWithFormat:@"@%@ accepted the %@ challenge!", self.primaryUser.username, self.challenge.title];
            break;
            
        case StoryTypeChallengeCompleted:
            text = [NSString stringWithFormat:@"@%@ took action for the %@ challenge!", self.primaryUser.username, self.challenge.title];
            break;
        case StoryTypeChallengeTagged:
            text = [NSString stringWithFormat:@"@%@ tagged @%@ in the %@ challenge!", self.primaryUser.username, self.secondaryUser.username, self.challenge.title];
            break;
        default:
            break;
    }
    return text;
}

@end
