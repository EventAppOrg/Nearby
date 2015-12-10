//
//  EventChatsViewController.h
//  Nearby
//
//  Created by Kavin Arasu on 12/7/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventChat.h"

@class EventChatsViewController;

@protocol EventChatsViewControllerDelegate <NSObject>

- (void) eventChatsViewController:(EventChatsViewController *) eventChatsViewController didAddNewChat:(EventChat *) eventChat;

@end

@interface EventChatsViewController : UIViewController

@property (nonatomic, strong) Event* event;

@property (nonatomic, weak) id<EventChatsViewControllerDelegate> delegate;

@end
