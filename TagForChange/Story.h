//
//  Story.h
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "Challenge.h"

typedef NS_ENUM(NSInteger, StoryType) {
    StoryTypeChallegeCompleted
};

@interface Story : PFObject <PFSubclassing>

@property (strong, nonatomic) NSNumber *storyType;
@property (strong, nonatomic) Challenge *challenge;
@property (strong, nonatomic) TFCUser *primaryUser;
@property (strong, nonatomic) TFCUser *secondaryUser;
@property (strong, nonatomic) NSNumber *likes;

+ (NSString *)parseClassName;

@end
