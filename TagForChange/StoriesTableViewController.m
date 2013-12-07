//
//  StoriesTableViewController.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "StoriesTableViewController.h"
#import "StoryTableViewCell.h"

@interface StoriesTableViewController ()

@end

@implementation StoriesTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.parseClassName = NSStringFromClass(Story.class);
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 100;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(2,0,0,0)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"butterfly_icon"]];
    
    imageView.frame = CGRectMake(160 - imageView.frame.size.width / 2, 20, imageView.frame.size.width, imageView.frame.size.height);
    [self.navigationController.view addSubview:imageView];
    
//    PFQuery *query = [TFCUser query];
//    NSArray *users = [query findObjects];
//    
//    Challenge *challenge = [Challenge object];
//    challenge.title = @"Check in with your people";
//    challenge.description = @"Ask someone nearby “how are you?” mean it and listen.";
//    challenge.initiator = users[arc4random() % users.count];
//    [challenge saveInBackground];
//    
//    Story *story = [Story object];
//    story.primaryUser = users[arc4random() % users.count];
//    story.secondaryUser = users[arc4random() % users.count];
//    story.storyType = @(arc4random() % 4);
//    story.challenge = challenge;
//    [story saveInBackground];
    
}

#pragma mark - Parse

- (PFQuery *)queryForTable
{
    PFQuery *query = [Story query];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"create_at"];
    
    return query;
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(Story *)story
{
    StoryTableViewCell *storyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(StoryTableViewCell.class)
                                                                    forIndexPath:indexPath];
    storyCell.story = story;
    
    return storyCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath object:(Story *)story
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath object:story];
    return cell.intrinsicContentSize.height;
}

@end
