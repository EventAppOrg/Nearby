//
//  EventViewController.m
//  Nearby
//
//  Created by Piotr Czubak on 11/24/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventViewController.h"
#import "EventsTableViewCell.h"
#import "LoginViewController.h"
#import "AddEventViewController.h"
#import "Event.h"
#import "EventUser.h"
#import "EventDetailViewController.h"

@interface EventViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *events;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EventViewController

- (void)viewDidLoad {
    self.title = @"Nearby";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleDone target:self action:@selector(logOut)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EventsTableViewCell" bundle:nil] forCellReuseIdentifier:@"eventCell"];
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // later we will need to include filters etc.
    [self updateView];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(onRefreshed:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    [super viewDidLoad];
}

- (void) onRefreshed:(UIRefreshControl*) refreshControl {
    [self updateView];
    [refreshControl endRefreshing];
}

- (void) updateView {
    [Event getEventsForUser: self.user completion:^(NSArray *events, NSError *error) {
        self.events = events;
        [self.tableView reloadData];
    }];
}

- (void)addEvent {
    AddEventViewController *aevc = [[AddEventViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:aevc animated:YES];
}

- (void)logOut {
    [PFUser logOut];
    LoginViewController *lvc = [[LoginViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:lvc];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Getting cell");
    
    EventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    Event *event = [self.events objectAtIndex:indexPath.row];
    cell.event = event;
    [EventUser getEventUserForEvent:event withStatus:@1 completion:^(NSArray *eventUsers, NSError *error) {
        cell.eventUsers = eventUsers;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EventDetailViewController *detailController = [[EventDetailViewController alloc] init];
    Event *event = [self.events objectAtIndex:indexPath.row];
    detailController.event = event;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
