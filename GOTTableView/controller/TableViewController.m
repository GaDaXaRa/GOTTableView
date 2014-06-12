//
//  TableViewController.m
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "TableViewController.h"
#import "GotModel.h"
#import "Personaje.h"
#import "Casa.h"
#import "GOTTableViewCell.h"
#import "PersonajeViewController.h"

@interface TableViewController ()

@property (nonatomic, strong)GotModel *model;
@end

@implementation TableViewController

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
    
    self.model = [[GotModel alloc] init];
    [self.model cargaModelo];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.title = @"Gente que va a morir";
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.casas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Casa *casa = [self.model.casas objectAtIndex:section];
    return casa.personajes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GOTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celda_personaje" forIndexPath:indexPath];
    
    Casa *casa = [self.model.casas objectAtIndex:indexPath.section];
    
    Personaje *personaje = [casa.personajes objectAtIndex:indexPath.row];
    
    cell.label.text = personaje.nombre;
    cell.personajeView.image = [UIImage imageNamed:personaje.imagen];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PersonajeViewController *personajeController = segue.destinationViewController;
    personajeController.delegate = self;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Casa *casa = [self.model.casas objectAtIndex:indexPath.section];
    Personaje *selectedPersonaje = [casa.personajes objectAtIndex:indexPath.row];
    
    personajeController.personaje = selectedPersonaje;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    Casa *casa = [self.model.casas objectAtIndex:section];
    UIImage *casaImage = [UIImage imageNamed:casa.imagen];
    return casaImage.size.height / 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Casa *casa = [self.model.casas objectAtIndex:section];
    UIImage *casaImage = [UIImage imageNamed:casa.imagen];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:casaImage];
    
    return imageView;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete ) {
        [self removePeronnajeFromModelAtIndexPath:indexPath];
        
    }
}

- (void)removePeronnajeFromModelAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    Casa *casa = [self.model.casas objectAtIndex:indexPath.section];
    Personaje *personaje = [casa.personajes objectAtIndex:indexPath.row];
    
    NSMutableArray *personajesArray = casa.personajes.mutableCopy;
    [personajesArray removeObject:personaje];
    
    casa.personajes = personajesArray.copy;
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Matar";
}

- (void)matarPersonaje {
    [self removePeronnajeFromModelAtIndexPath:[self.tableView indexPathForSelectedRow]];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
