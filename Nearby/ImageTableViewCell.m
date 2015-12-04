//
//  ImageTableViewCell.m
//  Nearby
//
//  Created by Kavin Arasu on 11/30/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ImageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end

@implementation ImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    NSURL *url = [NSURL URLWithString:_imageUrl];
    [self.cellImageView setImageWithURL:url];
}

@end
