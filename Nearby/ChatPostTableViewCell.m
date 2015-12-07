//
//  ChatPostTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 12/6/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "ChatPostTableViewCell.h"

@interface ChatPostTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *chatContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatDateLabel;


@end

@implementation ChatPostTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setEventChat:(EventChat *)eventChat {
    _eventChat = eventChat;
    if(_eventChat == nil) {
        self.chatContentLabel.text = @"No chat to display";
        self.userName.text = @"";
        self.chatDateLabel.text = @"";
    } else {
        self.userName.text = _eventChat.user.username;
        self.chatContentLabel.text = _eventChat.chatContent;
    }
}

@end
