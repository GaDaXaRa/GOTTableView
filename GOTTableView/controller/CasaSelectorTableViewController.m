//
//  CasaSelectorTableViewController.m
//  GOTTableView
//
//  Created by Miguel Santiago Rodríguez on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "CasaSelectorTableViewController.h"
#import "GotModel.h"
#import "Casa.h"
#import "CasaTableViewCell.h"

@interface CasaSelectorTableViewController ()
@property(strong, nonatomic) GotModel *model;
@end

@implementation CasaSelectorTableViewController

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CasaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"casaCell" forIndexPath:indexPath];
    
    Casa *casa = [self.model.casas objectAtIndex:indexPath.row];
    
    cell.casaName.text = casa.nombre;
    cell.casaImage.image = [UIImage imageNamed:casa.imageBig];
    
    return cell;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model.casas count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView == tableView) {
        Casa *casa = [self.model.casas objectAtIndex:indexPath.row];
        [self.delegate casaSelector:casa];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
