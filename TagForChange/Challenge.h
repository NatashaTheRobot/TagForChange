//
//  Challenge.h
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "Sponsor.h"

@interface Challenge : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) TFCUser *initiator;
@property (strong, nonatomic) Sponsor *sponsor;
@property (assign, nonatomic) BOOL suggested;

@end
