//
//  Tag.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "Tag.h"
#import <Parse/PFObject+Subclass.h>

@implementation Tag

@dynamic initiator;
@dynamic receiver;
@dynamic challenge;

+ (NSString *)parseClassName
{
    return @"Tag";
}

@end
