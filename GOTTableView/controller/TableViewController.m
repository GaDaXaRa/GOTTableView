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
@property (nonatomic, strong)NSArray *resultadosFiltrados;
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
    if (self.searchDisplayController.searchResultsTableView == tableView) {
        return 1;
    }
    return self.model.casas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
        [self.resultadosFiltrados count];
    }
    
    Casa *casa = [self.model.casas objectAtIndex:section];
    return casa.personajes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    
    
    if (self.searchDisplayController.searchResultsTableView == tableView) {
        GOTTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"celdaPersonaje" forIndexPath:indexPath];
        Personaje *personaje = [self.resultadosFiltrados objectAtIndex:indexPath.row];
        cell.label.text = personaje.nombre;
        cell.personajeView.image = [UIImage imageNamed:personaje.imagen];
        return cell;
    }
    
    GOTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaPersonaje" forIndexPath:indexPath];
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
    if ([segue.identifier isEqualToString:@"muestraDetalle"]) {
        PersonajeViewController *personajeController = segue.destinationViewController;
        personajeController.delegate = self;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Casa *casa = [self.model.casas objectAtIndex:indexPath.section];
        Personaje *selectedPersonaje = [casa.personajes objectAtIndex:indexPath.row];
        
        personajeController.personaje = selectedPersonaje;
    } else if ([segue.identifier isEqualToString:@"addSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddPersonajeTableViewController *addPersonajeController = navigationController.childViewControllers[0];
        addPersonajeController.delegate = self;
    }
    
}

- (IBAction)backFromModal:(UIStoryboardSegue *)segue {
    
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

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    Casa *casaOrigen = [self.model.casas objectAtIndex:sourceIndexPath.section];
    NSMutableArray *personajesOrigen = casaOrigen.personajes.mutableCopy;
    Personaje *personajeOrigen = [casaOrigen.personajes objectAtIndex:sourceIndexPath.row];
    [personajesOrigen removeObjectAtIndex:sourceIndexPath.row];
    casaOrigen.personajes = personajesOrigen.copy;
    
    Casa *casaDestino = [self.model.casas objectAtIndex:destinationIndexPath.section];
    NSMutableArray *personajesDestino = casaDestino.personajes.mutableCopy;
    [personajesDestino insertObject:personajeOrigen atIndex:destinationIndexPath.row];
    casaDestino.personajes = personajesDestino.copy;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)addPersonaje:(Personaje *)personaje inCasa:(Casa *)casa {
    int casaIndex = [self indexOfCasa:casa];
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:casa.personajes.count inSection:casaIndex];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    Casa *updatedCasa = [self.model.casas objectAtIndex:casaIndex];
    NSMutableArray *personajes = updatedCasa.personajes.mutableCopy;
    [personajes addObject:personaje];
    updatedCasa.personajes = personajes.copy;
    [self.tableView endUpdates];
}

- (NSUInteger) indexOfCasa:(Casa *)casa {
    for (int i = 0; i < self.model.casas.count; i ++) {
        Casa *casaAtIndex = self.model.casas[i];
        if ([casaAtIndex.nombre isEqualToString:casa.nombre]) {
            return i;
        }
    }
    
    return 0;
}

- (void)filtraPersonajesPorCadenaDeTexto:(NSString *) busqueda {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nombre contains[c] %@", busqueda];
    NSArray *todos =  [self.model.casas valueForKeyPath:@"@distinctUnionOfArrays.personajes"];
    self.resultadosFiltrados = [todos filteredArrayUsingPredicate:predicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filtraPersonajesPorCadenaDeTexto:searchString];
    return YES;
}

@end
