//
//  EventChatsViewController.m
//  Nearby
//
//  Created by Kavin Arasu on 12/7/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventChatsViewController.h"
#import "ChatPostTableViewCell.h"
#import "EventChat.h"

@interface EventChatsViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chatsTableView;
@property (strong, nonatomic) NSArray *eventChats;

@end

@implementation EventChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(onCloseTapped)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    [self.chatsTableView registerNib:[UINib nibWithNibName:@"ChatPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatPostCell"];
    self.chatsTableView.dataSource = self;
    self.chatsTableView.rowHeight = UITableViewAutomaticDimension;
    self.chatsTableView.estimatedRowHeight = 120;
    // Do any additional setup after loading the view from its nib.
}

- (void) onCloseTapped {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventChats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatPostTableViewCell *cell = [self.chatsTableView dequeueReusableCellWithIdentifier:@"chatPostCell"];
    cell.eventChat = self.eventChats[indexPath.row];
    return cell;
}

- (void) setEvent:(Event *)event {
    _event = event;
    [EventChat getEventChatsForEvent:_event completion:^(NSArray *eventChats, NSError *error) {
        if(!error) {
            self.eventChats = eventChats;
            [self.chatsTableView reloadData];
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
