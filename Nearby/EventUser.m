//
//  EventUser.m
//  Nearby
//
//  Created by Kavin Arasu on 11/26/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventUser.h"

@implementation EventUser

@dynamic user;
@dynamic status;

+ (NSString *)parseClassName {
    return @"EventUser";
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


@end
