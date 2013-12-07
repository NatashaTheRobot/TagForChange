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
        
        [Challenge registerSubclass];
        [Story registerSubclass];
        
        Challenge *challenge = [Challenge object];
        challenge.title = @"Riders";
        challenge.description = @"Ride into the sunset";
        challenge.initiator = [TFCUser currentUser];
        challenge.suggested = YES;
        [challenge save];
        
        // create story
        Story *story = [Story object];
        story.primaryUser = [TFCUser currentUser];
        story.likes = @5;
        story.challenge = challenge;
        [story save];
        
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
    storyCell.textLabel.text = @"hello";
    
    return storyCell;
}


@end