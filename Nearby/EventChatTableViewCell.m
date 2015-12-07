//
//  EventChatTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 12/5/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventChatTableViewCell.h"
#import "ChatPostTableViewCell.h"

@interface EventChatTableViewCell () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (nonatomic) BOOL isEmpty;

@end

@implementation EventChatTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.chatTableView registerNib:[UINib nibWithNibName:@"ChatPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatPostCell"];
    self.chatTableView.dataSource = self;
    self.chatTableView.estimatedRowHeight = 120;
    self.chatTableView.rowHeight = UITableViewAutomaticDimension;
    self.chatTableView.separatorColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_eventChats.count == 0) {
        self.isEmpty = YES;
        return 1;
    } else {
        self.isEmpty = NO;
        return _eventChats.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatPostTableViewCell *cell = [self.chatTableView dequeueReusableCellWithIdentifier:@"chatPostCell"];
    if(!self.isEmpty) {
        cell.eventChat = self.eventChats[indexPath.row];
    } else {
        cell.eventChat = nil;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setEventChats:(NSArray *)eventChats {
    _eventChats = eventChats;
    [self.chatTableView reloadData];
}

@end
