//
//  TagsTableViewController.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "TagsTableViewController.h"
#import "StoryTableViewCell.h"

@interface TagsTableViewController ()

@end

@implementation TagsTableViewController

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
    
    
    //    Challenge *challenge = [Challenge object];
    //    challenge.title = @"Chime for Change";
    //    challenge.description = @"Teach something";
    //    challenge.initiator = [TFCUser currentUser];
    //    challenge.suggested = YES;
    //    [challenge save];
    //
    //    // create story
    //    Story *story = [Story object];
    //    story.primaryUser = [TFCUser currentUser];
    //    story.likes = @5;
    //    story.challenge = challenge;
    //    [story save];
    
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
    
    [query orderByAscending:@"title"];
    
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
