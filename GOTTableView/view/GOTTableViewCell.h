//
//  GOTTableViewCell.h
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOTTableViewCell : UITableViewCell
@property (nonatomic)CGFloat height;
@property (weak, nonatomic)IBOutlet UILabel* label;
@property (weak, nonatomic) IBOutlet UIImageView *personajeView;

@end
