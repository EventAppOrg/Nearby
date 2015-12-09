//
//  InviteeTableViewCell.h
//  Nearby
//
//  Created by Piotr Czubak on 12/8/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InviteeTableViewCell;

@protocol InviteeTableViewCellDelegate <NSObject>

- (void)InviteeTableViewCell:(InviteeTableViewCell *)cell;

@end

@interface InviteeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (nonatomic, weak) id<InviteeTableViewCellDelegate> delegate;

@end
