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

+ (void) getEventUser:(PFUser *)user forEvent:(Event *) event completion:(void (^)(EventUser *eventUser, NSError *error))completion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"event = %@ AND user = %@ ", event, user];
    PFQuery *query = [EventUser queryWithPredicate:predicate];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error) {
            completion((EventUser*)object, nil);
        } else {
            completion(nil, error);
        }
    }];
}

+ (void) getEventUserForEvent:(Event *) event withStatus:(NSNumber *) status completion:(void (^)(NSArray *eventUsers, NSError *error))completion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"event = %@ AND status = %@", event, status];
    PFQuery *query = [EventUser queryWithPredicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(!error) {
            completion(objects, nil);
        } else {
            completion(nil, error);
        }
    }];
}

+ (void) getEventUserForEvent:(Event *) event completion:(void (^)(NSArray *eventUsers, NSError *error))completion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"event = %@", event];
    PFQuery *query = [EventUser queryWithPredicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(!error) {
            completion(objects, nil);
        } else {
            completion(nil, error);
        }
    }];
}


+ (void)updateEventUser:(EventUser *) eventUser withStatus:(NSNumber *) status completion:(void (^)(EventUser * eventUser, NSError *error))completion {
    eventUser.status = status;
    [eventUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded) {
            completion(eventUser, nil);
        } else {
            completion(nil, error);
        }
    }];
}

+ (void)createEventUser:(PFUser *)user forEvent:(Event *) event withStatus:(NSNumber *) status completion:(void (^)(EventUser *eventUser, NSError *error))completion {
    EventUser *eventUser = [[EventUser alloc] init];
    eventUser.event = event;
    eventUser.user = user;
    eventUser.status = status;
    [eventUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        completion(eventUser, error);
    }];
}

@end
