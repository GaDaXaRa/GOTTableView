//
//  CasaTableViewCell.h
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CasaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *casaName;
@property (weak, nonatomic) IBOutlet UIImageView *casaImage;

- (void)setOffset:(CGFloat)offset;

@end
