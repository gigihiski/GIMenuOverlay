//
//  MOViewController.m
//  GIMenuOverlay
//
//  Created by Gigih Iski Prasetyawan on 9/15/14.
//  Copyright (c) 2014 Etsuri Ltd. All rights reserved.
//

#import "MOViewController.h"
#import "GIMenuOverlay/GIMenuOverlay.h"

@interface MOViewController () <GIMenuDelegate>

@end

@implementation MOViewController {
    NSMutableArray *dataArray;
    
    GIMenuOverlay *circleMenu;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"First Cell", @"Second Cell", @"Third Cell", nil];
    
    // Init of Cirlce Menu Overlay
    circleMenu = [[GIMenuOverlay alloc] initWithTableView:self.tableView];
    [circleMenu setDelegate:self];
    [circleMenu setView:self.view];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [[cell textLabel] setText:[dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

#pragma mark - GICircleMenu
- (void) response:(NSIndexPath *)indexPath {
    NSLog(@"indexPath : %@", indexPath);
}

- (void) selectedMenu:(FMFeedMenuEnum)indexMenu {
    
}

@end
