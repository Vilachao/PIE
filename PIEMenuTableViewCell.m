//
//  PIEMenuTableViewCell.m
//  PIE
//
//  Created by Agustín on 10/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEMenuTableViewCell.h"

@implementation PIEMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
