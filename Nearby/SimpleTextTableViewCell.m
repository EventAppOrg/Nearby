//
//  SimpleTextTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 12/3/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "SimpleTextTableViewCell.h"

@interface SimpleTextTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation SimpleTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setEvent:(Event *)event {
    _event = event;
    if(_event.descriptionContent) {
        self.descriptionLabel.text = _event.descriptionContent;
    } else {
        self.descriptionLabel.text = @"This event has no description";
    }
    
}

@end
