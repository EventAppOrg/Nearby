//
//  EventUser.h
//  Nearby
//
//  Created by Kavin Arasu on 11/26/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#import "EventUser.h"

@interface EventUser : PFObject <PFSubclassing>

@property (retain) PFUser *user;

// 1 = going, 2 = maybe, 3 = not going, 4 = not answered
@property (retain) NSNumber *status;

+ (void)updateEventUser:(EventUser *) eventUser withStatus:(NSNumber *) status completion:(void (^)(EventUser * eventUser, NSError *error))completion;

@end
