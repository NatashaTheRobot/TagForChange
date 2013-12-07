//
//  LoginViewController.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "LoginViewController.h"
#import "PFTwitterUtils+NativeTwitter.h"

@interface LoginViewController () <UIActionSheetDelegate>

@property (strong, nonatomic) NSArray *twitterAccounts;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)onSignInWithTwitterButtonTap:(id)sender
{
    __weak LoginViewController *weakSelf = self;
    
    [PFTwitterUtils initializeWithConsumerKey:TWITTER_CONSUMER_KEY consumerSecret:TWITTER_CONSUMER_SECRET];
    
    [PFTwitterUtils setNativeLogInSuccessBlock:^(PFUser *user, NSString *userTwitterId, NSError *error) {
        NSLog(@"success!!!");
    }];
    
    
    
    [PFTwitterUtils getTwitterAccounts:^(BOOL accountsWereFound, NSArray *twitterAccounts) {
        if (accountsWereFound) {
            if (twitterAccounts.count > 1) {
                weakSelf.twitterAccounts = twitterAccounts;
                [weakSelf displayTwitterAccounts:twitterAccounts];
            } else {
                [PFTwitterUtils logInWithAccount:twitterAccounts[0]];
            }
        }
    }];
    
}

#pragma mark - Private Methods

- (void)displayTwitterAccounts:(NSArray *)twitterAccounts
{
    __block UIActionSheet *selectTwitterAccountsActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Twitter Account"
                                                                                          delegate:self
                                                                                 cancelButtonTitle:nil
                                                                            destructiveButtonTitle:nil
                                                                                 otherButtonTitles:nil];

    [twitterAccounts enumerateObjectsUsingBlock:^(id twitterAccount, NSUInteger idx, BOOL *stop) {
        [selectTwitterAccountsActionSheet addButtonWithTitle:[twitterAccount username]];
    }];
    selectTwitterAccountsActionSheet.cancelButtonIndex = [selectTwitterAccountsActionSheet addButtonWithTitle:@"Cancel"];
    
    [selectTwitterAccountsActionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [PFTwitterUtils logInWithAccount:self.twitterAccounts[buttonIndex]];
    }
}

@end
