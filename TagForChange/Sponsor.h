//
//  Sponsor.h
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

@interface Sponsor : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;

+ (NSString *)parseClassName;

@end
