//
//  EventViewController.m
//  Nearby
//
//  Created by Piotr Czubak on 11/24/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventViewController.h"
#import "EventsTableViewCell.h"
#import "Event.h"

@interface EventViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *events;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EventViewController

- (void)viewDidLoad {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EventsTableViewCell" bundle:nil] forCellReuseIdentifier:@"eventCell"];
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // later we will need to include filters etc.
    [Event getEventsForUser: self.user completion:^(NSArray *events, NSError *error) {
        self.events = events;
        [self.tableView reloadData];
    }];
    
    [super viewDidLoad];
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


@end
