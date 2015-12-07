//
//  EventChat.m
//  Nearby
//
//  Created by Kavin Arasu on 12/6/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventChat.h"

@implementation EventChat

@dynamic event;
@dynamic user;
@dynamic chatContent;

+ (NSString *)parseClassName {
    return @"EventChat";
}

+ (void)getEventChatsForEvent:(Event *)event completion:(void (^)(NSArray *eventChats, NSError *error))completion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"event = %@", event];
    PFQuery *query = [EventChat queryWithPredicate:predicate];
    [query includeKey:@"user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Objects %@", objects);
            completion(objects, nil);
        } else {
            NSLog(@"Error: %@", error);
            completion(nil, error);
        }
    }];
}

+ (void)createEventChatForEvent:(Event *)event forUser:(PFUser *) user withText:(NSString *) chatContent completion:(void (^)(EventChat *eventChat, NSError *error))completion {
    EventChat *eventChat = [[EventChat alloc] init];
    eventChat.event = event;
    eventChat.user = user;
    eventChat.chatContent = chatContent;
    [eventChat saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error) {
            completion(eventChat, nil);
        } else {
            completion(nil, error);
        }
    }];
}

@end
