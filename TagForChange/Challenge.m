//
//  Challenge.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "Challenge.h"
#import <Parse/PFObject+Subclass.h>

@implementation Challenge

@dynamic title;
@dynamic description;
@dynamic initiator;
@dynamic suggested;
@dynamic sponsor;

+ (NSString *)parseClassName
{
    return @"Challenge";
}

@end
