//
//  EventStatsTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 12/3/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventStatsTableViewCell.h"

@interface EventStatsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *maybeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmedCountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *userStatusControl;

@end

@implementation EventStatsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setEvent:(Event *)event {
    _event = event;
    [self updateView];
}

- (void) updateView {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status==%ld", 1];
    NSArray *confirmedUsers = [self.event.eventUsers filteredArrayUsingPredicate:predicate];
    NSPredicate *maybePredicate = [NSPredicate predicateWithFormat:@"status==%ld", 2];
    NSArray *maybeUsers = [self.event.eventUsers filteredArrayUsingPredicate:maybePredicate];
    self.confirmedCountLabel.text = [[NSNumber numberWithLong:confirmedUsers.count] stringValue];
    self.maybeCountLabel.text = [[NSNumber numberWithLong:maybeUsers.count] stringValue];
    if(self.event.eventUsers) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user.objectId==%@",[PFUser currentUser].objectId];
        EventUser *eventUs = [[self.event.eventUsers filteredArrayUsingPredicate:predicate] objectAtIndex:0];
        NSInteger status = [eventUs.status integerValue] - 1;
        [self.userStatusControl setSelectedSegmentIndex:status];
    }
}

- (IBAction)onUserStatusChanged:(UISegmentedControl *)sender {
    NSNumber *status = [NSNumber numberWithInteger:self.userStatusControl.selectedSegmentIndex + 1];
    PFUser *currentUser = [PFUser currentUser];
    if(self.event.eventUsers) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user.objectId==%@",[PFUser currentUser].objectId];
        EventUser *eventUs = [[self.event.eventUsers filteredArrayUsingPredicate:predicate] objectAtIndex:0];
        if(eventUs) {
            [EventUser updateEventUser:eventUs withStatus:status completion:^(EventUser *eventUser, NSError *error) {
                if(!error) {
                    [self updateView];
                }
            }];
        } else {
            [Event createEventUser:currentUser forEvent:self.event withStatus:status completion:^(Event *event, NSError *error) {
                //        NSLog(@"Status success");
                self.event = event;
                [self updateView];
            }];
        }
    } else {
        [Event createEventUser:currentUser forEvent:self.event withStatus:status completion:^(Event *event, NSError *error) {
            //        NSLog(@"Status success");
            self.event = event;
            [self updateView];
        }];
    }
}

@end
