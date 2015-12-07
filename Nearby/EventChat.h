//
//  EventChat.h
//  Nearby
//
//  Created by Kavin Arasu on 12/6/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Event.h"

@interface EventChat : PFObject <PFSubclassing>

@property (retain) Event* event;
@property (retain) PFUser* user;
@property (retain) NSString* chatContent;

+ (void)getEventChatsForEvent:(Event *)event completion:(void (^)(NSArray *eventChats, NSError *error))completion;

+ (void)createEventChatForEvent:(Event *)event forUser:(PFUser *) user withText:(NSString *) chatContent completion:(void (^)(EventChat *eventChat, NSError *error))completion;

@end
