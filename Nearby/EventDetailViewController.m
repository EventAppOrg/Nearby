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

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateView];
    // Do any additional setup after loading the view from its nib.
}

- (void) updateView {
    self.eventTitleLabel.text = _event.eventName;
    self.addressLabel.text = _event.address;
    self.confirmedCountLabel.text = [_event.confirmedCount stringValue];
    self.maybeCountLabel.text = [_event.maybeCount stringValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d MMM yyyy";
    NSString *dateValue = [formatter stringFromDate:_event.eventDate];
    NSLog(@"test %@", dateValue);
    self.eventDateLabel.text = dateValue;
    NSURL *url = [NSURL URLWithString:_event.imageUrl];
    [self.eventImageView setImageWithURL:url];

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
    NSLog(@"test %@", dateValue);
    self.eventDateLabel.text = dateValue;
    NSURL *url = [NSURL URLWithString:event.imageUrl];
    [self.eventImageView setImageWithURL:url];

    
}
- (IBAction)onEventUserStatusChanged:(UISegmentedControl *)sender {
    NSNumber *status = [NSNumber numberWithInteger:self.userStatusControl.selectedSegmentIndex + 1];
    PFUser *currentUser = [PFUser currentUser];
    [EventUser createEventUser:currentUser forEvent:self.event withStatus:status completion:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"Successful");
        } else {
            NSLog(@"Not Successful");
        }
    }];
    NSLog(@"user changed %ld", (long)self.userStatusControl.selectedSegmentIndex);
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
