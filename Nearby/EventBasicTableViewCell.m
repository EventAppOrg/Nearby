//
//  EventBasicTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 12/1/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventBasicTableViewCell.h"

@interface EventBasicTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;


@end

@implementation EventBasicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setEvent:(Event *)event {
    _event = event;
    self.titleLabel.text = _event.eventName;
    self.addressLabel.text = _event.address;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d MMM yyyy";
    NSString *dateValue = [formatter stringFromDate:_event.eventDate];
    self.dateTimeLabel.text = dateValue;
}

@end
