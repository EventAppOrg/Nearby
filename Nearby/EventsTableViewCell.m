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
@property (weak, nonatomic) IBOutlet UILabel *inviteLabel;

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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status==%ld", 1];
    NSArray *confirmedUsers = [self.event.eventUsers filteredArrayUsingPredicate:predicate];
    self.confirmedCountLabel.text = [NSString stringWithFormat:@"%ld going", confirmedUsers.count];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d MMM yyyy";
    NSString *dateValue = [formatter stringFromDate:event.eventDate];
    self.dateTimeLabel.text = dateValue;
    self.categoryLabel.text = event.category;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.1f mi", [event.distance doubleValue]];
    NSURL *url;
    if(event.imageUrl) {
        url = [NSURL URLWithString:event.imageUrl];
    } else {
        url = [NSURL URLWithString:@"http://www.qatarvision.com/images/services/events/event-services-banner.jpg"];
    }
    [self.eventImageView setImageWithURL:url];
    predicate = [NSPredicate predicateWithFormat:@"status==%ld", 4];
    if(self.event.eventUsers && [self.event.eventUsers filteredArrayUsingPredicate:predicate].count != 0) {
        EventUser *eventUser = [[self.event.eventUsers filteredArrayUsingPredicate:predicate] objectAtIndex:0];
        if([eventUser.status integerValue] == 4) {
            self.inviteLabel.alpha = 1;
        } else {
            self.inviteLabel.alpha = 0;
        }
    } else {
        self.inviteLabel.alpha = 0;
    }
//    self.dateTimeLabel.text = event.eventDate;
}

- (void) setConfirmedUsers:(NSArray *)confirmedUsers {
    _confirmedUsers = confirmedUsers;
//    self.confirmedCountLabel.text = [NSString stringWithFormat:@"%@ going", [NSNumber numberWithInteger:confirmedUsers.count]];
}

@end
