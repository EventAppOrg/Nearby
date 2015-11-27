//
//  EventsTableViewCell.h
//  Nearby
//
//  Created by Kavin Arasu on 11/25/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventUser.h"

@interface EventsTableViewCell : UITableViewCell

@property (nonatomic, strong) Event *event;
@property (nonatomic, strong) NSArray *eventUsers;

@end
