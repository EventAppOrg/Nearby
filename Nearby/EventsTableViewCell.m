//
//  EventsTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 11/25/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventsTableViewCell.h"

@interface EventsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;

@end

@implementation EventsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setEvent:(Event *)event {
    _event = event;
    self.eventTitleLabel.text = event.eventName;
}

@end
