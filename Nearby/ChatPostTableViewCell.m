//
//  ChatPostTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 12/6/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "ChatPostTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ChatPostTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *chatContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chatImageView;


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
        if(_eventChat.imageUrl) {
            NSURL *url = [NSURL URLWithString:_eventChat.imageUrl];
            [self.chatImageView setImageWithURL:url];
            self.chatContentLabel.text = @"Image uploaded";
        } else {
            self.chatContentLabel.text = _eventChat.chatContent;
            [self.chatImageView removeFromSuperview];
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"d MMM yyyy h:mm a";
        NSString *dateValue = [formatter stringFromDate:_eventChat.createdAt];
        self.chatDateLabel.text = dateValue;
    }
}

@end
