//
//  EventsTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 11/25/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventsTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface EventsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;

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
    self.addressLabel.text = event.address;
    self.confirmedCountLabel.text = [NSString stringWithFormat:@"%@ going", [event.confirmedCount stringValue]];
    NSLog(@"%@", event.eventDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d MMM yyyy";
    NSString *dateValue = [formatter stringFromDate:event.eventDate];
    NSLog(@"%@", dateValue);
    self.dateTimeLabel.text = dateValue;
    self.categoryLabel.text = event.category;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.1f mi", [event.distance doubleValue]];
    NSURL *url = [NSURL URLWithString:event.imageUrl];
    [self.eventImageView setImageWithURL:url];
//    self.dateTimeLabel.text = event.eventDate;
}

@end
