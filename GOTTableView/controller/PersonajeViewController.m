//
//  PersonajeViewController.m
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "PersonajeViewController.h"

@interface PersonajeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *personajeImage;
@property (weak, nonatomic) IBOutlet UITextView *personajeDescription;

@end

@implementation PersonajeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.personaje.nombre;
    self.personajeImage.image = [UIImage imageNamed:self.personaje.imagen];
    self.personajeDescription.text = self.personaje.descripcion;
    [self roundImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)roundImage {
    self.personajeImage.layer.cornerRadius = self.personajeImage.frame.size.height / 2;
    self.personajeImage.layer.masksToBounds = YES;
    self.personajeImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.personajeImage.layer.borderWidth = 2.0;
}

- (IBAction)matarButton:(id)sender {
    [self.delegate matarPersonaje];    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
