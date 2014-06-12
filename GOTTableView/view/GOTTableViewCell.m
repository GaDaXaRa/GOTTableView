//
//  GOTTableViewCell.m
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "GOTTableViewCell.h"

@implementation GOTTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self roundImage];
    }
    return self;
}

- (void)awakeFromNib
{
    [self roundImage];
    
}

- (void)roundImage {
    self.personajeView.layer.cornerRadius = self.personajeView.frame.size.height / 2;
    self.personajeView.layer.masksToBounds = YES;
    self.personajeView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.personajeView.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
