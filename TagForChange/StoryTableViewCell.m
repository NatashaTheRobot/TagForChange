//
//  StoryTableViewCell.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "StoryTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation StoryTableViewCell

- (void)prepareForReuse
{
    self.imageView.image = nil;
    self.textLabel.text = nil; 
}

- (void)setStory:(Story *)story
{
    _story = story;
    [story.primaryUser fetchIfNeeded];
    [self.imageView setImageWithURL:[NSURL URLWithString:story.primaryUser.image_url]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.textLabel.text = [story text];
}

@end
