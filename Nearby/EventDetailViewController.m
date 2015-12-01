//
//  EventDetailViewController.m
//  Nearby
//
//  Created by Kavin Arasu on 11/26/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "EventUser.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *maybeCountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *userStatusControl;
@property (nonatomic, strong) EventUser *eventUser;
@property (nonatomic) NSInteger confirmedUsers;
@property (nonatomic) NSInteger maybeUsers;
@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateView];
}

- (void) updateView {
    self.eventTitleLabel.text = _event.eventName;
    self.addressLabel.text = _event.address;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status==%ld", 1];
    NSArray *confirmedUsers = [self.event.eventUsers filteredArrayUsingPredicate:predicate];
    NSPredicate *maybePredicate = [NSPredicate predicateWithFormat:@"status==%ld", 2];
    NSArray *maybeUsers = [self.event.eventUsers filteredArrayUsingPredicate:maybePredicate];
    self.confirmedCountLabel.text = [[NSNumber numberWithLong:confirmedUsers.count] stringValue];
    self.maybeCountLabel.text = [[NSNumber numberWithLong:maybeUsers.count] stringValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d MMM yyyy";
    NSString *dateValue = [formatter stringFromDate:_event.eventDate];
    self.eventDateLabel.text = dateValue;
//    NSURL *url = [NSURL URLWithString:_event.imageUrl];
    NSURL *url;
    if(_event.imageUrl) {
        url = [NSURL URLWithString:_event.imageUrl];
    } else {
        url = [NSURL URLWithString:@"http://www.qatarvision.com/images/services/events/event-services-banner.jpg"];
    }
    [self.eventImageView setImageWithURL:url];
    if(self.event.eventUsers){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user.objectId==%@",[PFUser currentUser].objectId];
        EventUser *eventUs = [[self.event.eventUsers filteredArrayUsingPredicate:predicate] objectAtIndex:0];
        NSInteger status = [eventUs.status integerValue] - 1;
        [self.userStatusControl setSelectedSegmentIndex:status];

        NSLog(@"%@", eventUs);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setEvent:(Event *)event {
    _event = event;
    self.eventTitleLabel.text = event.eventName;
    self.addressLabel.text = event.address;
    self.confirmedCountLabel.text = [NSString stringWithFormat:@"%@", [event.confirmedCount stringValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d MMM yyyy";
    NSString *dateValue = [formatter stringFromDate:event.eventDate];
    self.eventDateLabel.text = dateValue;
    NSURL *url = [NSURL URLWithString:event.imageUrl];
    [self.eventImageView setImageWithURL:url];

    
}

- (IBAction)onEventUserStatusChanged:(UISegmentedControl *)sender {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
