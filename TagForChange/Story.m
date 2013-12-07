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

@end
