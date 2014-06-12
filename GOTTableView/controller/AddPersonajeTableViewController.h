//
//  AddPersonajeTableViewController.h
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Personaje.h"
#import "Casa.h"
#import "CasaSelectorTableViewController.h"

@protocol AdDPersonajeDelegate <NSObject>

- (void) addPersonaje:(Personaje *)personaje inCasa:(Casa *)casa;

@end

@interface AddPersonajeTableViewController : UITableViewController<CasaSelectorDelegate>

@property (weak, nonatomic) id<AdDPersonajeDelegate> delegate;

@end
