//
//  TableViewController.h
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonajeViewController.h"
#import "AddPersonajeTableViewController.h"

@interface TableViewController : UITableViewController<UITableViewDelegate, MatarDelegate, AdDPersonajeDelegate, UISearchDisplayDelegate>

@end
