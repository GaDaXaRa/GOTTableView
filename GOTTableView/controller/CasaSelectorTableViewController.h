//
//  CasaSelectorTableViewController.h
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Casa;
@protocol CasaSelectorDelegate <NSObject>

- (void)casaSelector:(Casa *)casa;

@end

@interface CasaSelectorTableViewController : UITableViewController<UITableViewDelegate>

@property (weak, nonatomic)id<CasaSelectorDelegate> delegate;

@end
