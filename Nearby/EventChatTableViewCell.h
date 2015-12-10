//
//  EventChatTableViewCell.h
//  Nearby
//
//  Created by Kavin Arasu on 12/5/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventChat.h"

@interface EventChatTableViewCell : UITableViewCell

@property (strong, nonatomic) NSMutableArray *eventChats;

- (void) insertEventChat:(EventChat *)eventChat;

@end
