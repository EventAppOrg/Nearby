//
//  EventBasicTableViewCell.h
//  Nearby
//
//  Created by Kavin Arasu on 12/1/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventBasicTableViewCell : UITableViewCell

@property (nonatomic, strong) Event* event;
@end
