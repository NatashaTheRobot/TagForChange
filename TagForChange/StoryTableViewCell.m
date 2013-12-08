//
//  StoryTableViewCell.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "StoryTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface StoryTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *storyText;
@property (weak, nonatomic) IBOutlet UILabel *numberOfParticipantsLable;


@end

@implementation StoryTableViewCell

- (void)prepareForReuse
{
    self.imageView.image = nil;
    self.textLabel.text = nil;
}

- (void)setStory:(Story *)story
{
    _story = story;
//    [story.primaryUser fetchIfNeeded];
//    [story.challenge fetchIfNeeded];
//    [story.secondaryUser fetchIfNeeded];
    StoryTableViewCell *weakSelf = self;
    [self.profileImage setImageWithURL:[NSURL URLWithString:story.primaryUser.image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error) {
            weakSelf.imageView.image = self.imageView.image = [UIImage imageNamed:@"egg"];
        }
    }];
    
//    [self.profileImage setImageWithURL:[NSURL URLWithString:story.primaryUser.image_url]
//                   placeholderImage:[UIImage imageNamed:@"egg"]];
    
    self.storyText.attributedText = [story text];
    self.numberOfParticipantsLable.text = [NSString stringWithFormat:@"%i", arc4random() % 99 + 1];
}

@end
