//
//  EventUser.m
//  Nearby
//
//  Created by Kavin Arasu on 11/26/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventUser.h"

@implementation EventUser

@dynamic event;
@dynamic user;
@dynamic status;

+ (NSString *)parseClassName {
    return @"EventUser";
}

+ (void)createEventUser:(PFUser *)user forEvent:(Event *) event withStatus:(NSNumber *) status completion:(void (^)(BOOL succeeded, NSError *error))completion {
    EventUser *eventUser = [[EventUser alloc] init];
    eventUser.event = event;
    eventUser.user = user;
    eventUser.status = status;
    [eventUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        completion(succeeded, error);
    }];
}

@end
