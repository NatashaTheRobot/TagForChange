//
//  Sponsor.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "Sponsor.h"
#import <Parse/PFObject+Subclass.h>

@implementation Sponsor

@dynamic title;
@dynamic description;

+ (NSString *)parseClassName
{
    return @"Sponsor";
}

@end
