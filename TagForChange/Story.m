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

- (NSAttributedString *)text
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
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = [text rangeOfString:self.challenge.title];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:range];
    
    return str;
}

@end
