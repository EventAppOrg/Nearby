//
//  User.h
//  Nearby
//
//  Created by Piotr Czubak on 11/24/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <Parse/Parse.h>
#import "EventUser.h"

@interface Event : PFObject <PFSubclassing>

@property (retain) PFUser *owner;
@property (retain) NSString *eventName;
@property (retain) NSString *address;
@property (retain) NSDate *eventDate;
@property (retain) NSNumber *confirmedCount;
@property (retain) NSNumber *distance;
@property (retain) NSString *category;
@property (retain) NSString *imageUrl;
@property (retain) NSString *descriptionContent;
@property (retain) NSNumber *isPrivate;
@property (retain) NSNumber *maybeCount;
@property (retain) NSArray *eventUsers;

+ (NSString *)parseClassName;
+ (void)getEventsForUser:(PFUser *)user completion:(void (^)(NSArray *events, NSError *error))completion;
+ (void)createEventUser:(PFUser *)user forEvent:(Event *) event withStatus:(NSNumber *) status completion:(void (^)(Event *eventUser, NSError *error))completion;

@end
