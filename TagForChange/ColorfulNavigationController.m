//
//  ColorfulNavigationController.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "ColorfulNavigationController.h"

@interface ColorfulNavigationController ()

@end

@implementation ColorfulNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *barColour = [UIColor colorWithRed:131/255.0 green:225/255.0 blue:151/255.0 alpha:1];
    UIView *colourView = [[UIView alloc] initWithFrame:CGRectMake(0.f, -20.f, 320.f, 64.f)];
    colourView.opaque = NO;
    colourView.alpha = .7f;
    colourView.backgroundColor = barColour;
    self.navigationBar.barTintColor = barColour;
    [self.navigationBar.layer insertSublayer:colourView.layer atIndex:1];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
}

@end
