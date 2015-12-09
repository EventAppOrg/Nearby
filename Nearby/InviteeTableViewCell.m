//
//  InviteeTableViewCell.m
//  Nearby
//
//  Created by Piotr Czubak on 12/8/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "InviteeTableViewCell.h"

@implementation InviteeTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onClick:(id)sender {
    NSLog(@"Button clicked");
    [self.delegate InviteeTableViewCell:self];
}

@end
