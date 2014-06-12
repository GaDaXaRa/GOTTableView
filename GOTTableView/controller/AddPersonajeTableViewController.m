//
//  AddPersonajeTableViewController.m
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "AddPersonajeTableViewController.h"

@interface AddPersonajeTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextFiel;
@property (weak, nonatomic) IBOutlet UILabel *casaName;
@property (strong, nonatomic) Casa* selectedCasa;

@end

@implementation AddPersonajeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)savePersonaje:(id)sender {
    if ([self.nameTextField.text isEqualToString:@""] || [self.descriptionTextFiel.text isEqualToString:@""] || !self.selectedCasa) {
        return;
    }
    
    Personaje *personaje = [[Personaje alloc] init];
    personaje.nombre = self.nameTextField.text;
    personaje.descripcion = self.descriptionTextFiel.text;
    [self.delegate addPersonaje:personaje inCasa:self.selectedCasa];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)casaSelector:(Casa *)casa {
    self.selectedCasa = casa;
    self.casaName.text = casa.nombre;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"selectCasa"]) {
        CasaSelectorTableViewController *casaSelectorController = segue.destinationViewController;
        casaSelectorController.delegate = self;
    }
}

@end
