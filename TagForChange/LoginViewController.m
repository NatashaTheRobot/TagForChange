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
@property (assign, nonatomic) id selectedTwitterAccount;

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
    
    [PFTwitterUtils setNativeLogInSuccessBlock:^(PFUser *parseUser, NSString *userTwitterId, NSError *error) {
        NSString * requestString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/users/show.json?screen_name=%@", [weakSelf.selectedTwitterAccount username]];
        
        NSURL *verify = [NSURL URLWithString:requestString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:verify];
        [[PFTwitterUtils twitter] signRequest:request];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSError *error;
            NSDictionary* result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (!error) {
                TFCUser *user = (TFCUser *)parseUser;
                user.username = result[@"screen_name"];
                user.name= result[@"name"];
                user.image_url = [result[@"profile_image_url"] stringByReplacingOccurrencesOfString:@"_normal" withString:@"_bigger"];
                user.uuidString = [[NSUUID UUID] uuidString];
                [user saveEventually];
            }
        }];
        
    }];
    
    [PFTwitterUtils getTwitterAccounts:^(BOOL accountsWereFound, NSArray *twitterAccounts) {
        if (accountsWereFound) {
            if (twitterAccounts.count > 1) {
                weakSelf.twitterAccounts = twitterAccounts;
                [weakSelf displayTwitterAccounts:twitterAccounts];
            } else {
                weakSelf.selectedTwitterAccount = twitterAccounts[0];
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
        self.selectedTwitterAccount = self.twitterAccounts[buttonIndex];
        [PFTwitterUtils logInWithAccount:self.twitterAccounts[buttonIndex]];
    }
}

@end
