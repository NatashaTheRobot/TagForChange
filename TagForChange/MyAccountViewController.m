//
//  MyAccountViewController.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "MyAccountViewController.h"

@interface MyAccountViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *suggestedChallengesImageView;
@property (weak, nonatomic) IBOutlet UIImageView *completedChallengesImageView;

@end

@implementation MyAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)onChallengeButtonTap:(id)sender
{
    self.suggestedChallengesImageView.alpha = 0;
    self.completedChallengesImageView.alpha = 1;
}

- (IBAction)onSuggestedChallengesButtonTap:(id)sender
{
    self.completedChallengesImageView.alpha = 0;
    self.suggestedChallengesImageView.alpha = 1;
}
@end
