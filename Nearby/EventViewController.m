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
@property (nonatomic) NSInteger eventRequestType;

@end

@implementation EventViewController

- (EventViewController*) initWithAllEvents {
    self = [super init];
    if(self) {
        self.eventRequestType = 0;
    }
    return self;
}

- (EventViewController*) initWithMyEvents {
    self = [super init];
    if(self) {
        self.eventRequestType = 1;
    }
    return self;
}


- (void)viewDidLoad {
    self.events = [[NSMutableArray alloc] init];
    self.title = @"Nearby";
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

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void) onRefreshed:(UIRefreshControl*) refreshControl {
    [self updateView];
    [refreshControl endRefreshing];
}

- (void) updateView {
    if(self.eventRequestType == 0) {
        [Event getEventsForUser: self.user completion:^(NSArray *events, NSError *error) {
            self.events = events;
            [self.tableView reloadData];
        }];
    } else {
        [Event getMyEventsForUser: self.user completion:^(NSArray *events, NSError *error) {
            self.events = events;
            [self.tableView reloadData];
        }];
    }
}

- (void)addEvent {
    AddEventViewController *aevc = [[AddEventViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:aevc animated:YES];
}

- (void)logOut {
    [PFUser logOut];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDidLogoutNotification" object:nil];
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
