//
//  PersonajeViewController.h
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Personaje.h"

@protocol MatarDelegate <NSObject>

- (void)matarPersonaje;

@end

@interface PersonajeViewController : UIViewController
@property (strong, nonatomic)Personaje *personaje;
@property (weak, nonatomic)id<MatarDelegate> delegate;
@end
