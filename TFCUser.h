//
//  TFCUser.h
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

@interface TFCUser : PFUser <PFSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image_url;
@property (strong, nonatomic) NSString *uuidString;

@end
