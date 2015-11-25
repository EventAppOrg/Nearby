//
//  EventViewController.m
//  Nearby
//
//  Created by Piotr Czubak on 11/24/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventViewController.h"
#import "Event.h"

@interface EventViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *events;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EventViewController

- (void)viewDidLoad {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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
    
    // replace with proper cell setup
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EventCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Event *event = [self.events objectAtIndex:indexPath.row];
    
    cell.textLabel.text = event.eventName;
    return cell;
}


@end
