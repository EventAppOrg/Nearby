//
//  MenuTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 12/7/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "MenuTableViewCell.h"

@interface MenuTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *menuLabel;


@end

@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    [self.iconImageView setImage:_iconImage];
}

- (void) setLabel:(NSString *)label {
    NSLog(@"Setting label as %@", label);
    self.menuLabel.text = label;
}


@end
