//
//  User.h
//  Nearby
//
//  Created by Piotr Czubak on 11/24/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <Parse/Parse.h>

@interface Event : PFObject <PFSubclassing>

@property (retain) PFUser *owner;
@property (retain) NSString *eventName;

+ (NSString *)parseClassName;
+ (void)getEventsForUser:(PFUser *)user completion:(void (^)(NSArray *events, NSError *error))completion;

@end
