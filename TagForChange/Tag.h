//
//  Tag.h
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "Challenge.h"

@interface Tag : PFObject <PFSubclassing>

@property (strong, nonatomic) TFCUser *initiator;
@property (strong, nonatomic) TFCUser *receiver;
@property (strong, nonatomic) Challenge *challenge;

+ (NSString *)parseClassName;

@end
