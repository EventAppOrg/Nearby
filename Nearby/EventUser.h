//
//  EventUser.h
//  Nearby
//
//  Created by Kavin Arasu on 11/26/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Event.h"
#import "EventUser.h"

@interface EventUser : PFObject <PFSubclassing>

@property (retain) PFUser *user;

@property (retain) Event *event;

@property (retain) NSNumber *status;

+ (void) getEventUser:(PFUser *)user forEvent:(Event *) event completion:(void (^)(EventUser *eventUser, NSError *error))completion;

+ (void)updateEventUser:(EventUser *) eventUser withStatus:(NSNumber *) status completion:(void (^)(EventUser * eventUser, NSError *error))completion;

+ (void)createEventUser:(PFUser *)user forEvent:(Event *) event withStatus:(NSNumber *) status completion:(void (^)(EventUser * eventUser, NSError *error))completion;

@end
