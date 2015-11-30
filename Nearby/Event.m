//
//  User.m
//  Nearby
//
//  Created by Piotr Czubak on 11/24/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "Event.h"
#import "EventUser.h"

@implementation Event

@dynamic eventName;
@dynamic owner;
@dynamic address;
@dynamic eventDate;
@dynamic confirmedCount;
@dynamic distance;
@dynamic category;
@dynamic imageUrl;
@dynamic description;
@dynamic isPrivate;
@dynamic maybeCount;
@dynamic eventUsers;

+ (NSString *)parseClassName {
    return @"Event";
}

+ (void)getEventsForUser:(PFUser *)user completion:(void (^)(NSArray *events, NSError *error))completion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isPrivate = nil OR isPrivate = NO"];
    PFQuery *query = [Event queryWithPredicate:predicate];
    [query includeKey:@"eventUsers"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        NSMutableArray *eventAndUsers = [[NSMutableArray alloc] init];
        if (!error) {
            NSLog(@"Objects %@", objects);
            completion(objects, nil);
        } else {
            NSLog(@"Error: %@", error);
            completion(nil, error);
        }
    }];
}


+ (void)createEventUser:(PFUser *)user forEvent:(Event *) event withStatus:(NSNumber *) status completion:(void (^)(Event *event, NSError *error))completion {
    EventUser *eventUser = [[EventUser alloc] init];
    eventUser.user = user;
    eventUser.status = status;
    [event addObject:eventUser forKey:@"eventUsers"];
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error) {
            completion(event, nil);
        } else {
            NSLog(@"Error: %@", error);
            completion(nil, error);
        }
    }];
}

@end
