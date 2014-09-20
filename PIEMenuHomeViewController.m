//
//  PIEMenuHomeViewController.m
//  AccionaPie
//
//  Created by Jose Maria on 13/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEMenuHomeViewController.h"
#import "PIEHomeViewController.h"
#import "PIEArtistsViewController.h"
#import "PIEVisitViewController.h"
#import "PIEAccessibilityViewController.h"
#import "PIENavigationMenuHomeController.h"
#import "PIEMenuTableViewCell.h"
#import "Constants.h"
#import "PIEutil.h"

@interface PIEMenuHomeViewController ()

@property PIENavigationMenuHomeController *navigationController;

@property id contentViewController;

@property NSArray * menuList;

//properti para saber si estoy en accesibiliad y cargar eml menu de iconos


@property NSArray * imagesAccesibilidad;

@property UITableViewCell *cell0;

@end

@implementation PIEMenuHomeViewController

/**
 *  Definimos en el viewDidLoad el aspecto del Menú refrosted
 */
static int menuSelect;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorColor = [UIColor colorWithRed:0.247 green:0.522 blue:0.565 alpha:1.000];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.imagesAccesibilidad = @[@"accesibilidadNin",@"accesibilidadMov",@"accesibilidadVisual",@"accesibilidadAuditiva"];
    [self makeMenu];
}

#pragma mark -
#pragma mark UITableView Delegate

/**
 *  Aspecto de la celda
 *
 *  @param tableView tabla
 *  @param cell      celda
 *  @param indexPath indexpath
 */

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.247 green:0.522 blue:0.565 alpha:1.000];
        self.cell0 = cell;
    }else
        cell.backgroundColor = [UIColor colorWithWhite:0.204 alpha:1.000];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.865 green:0.883 blue:0.966 alpha:1.000];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    
}
#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (menuSelect !=3) {
        return 44;
    }else
        return 77;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellMenu";

    if (menuSelect !=3) {
        UITableViewCell *  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.text=self.menuList[indexPath.row];
        return cell;
    }
    
    PIEMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.labelCell.text = self.menuList[indexPath.row];
    cell.labelCell.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    cell.imagenCell.image = [UIImage imageNamed:self.imagesAccesibilidad[indexPath.row]];
    return cell;
}



/**
 *  acción al pulsar la celda del menú refrosted
 *
 *  @param tableView table menu
 *  @param indexPath indexPath
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.247 green:0.522 blue:0.565 alpha:1.000];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row!=0) {
        self.cell0.backgroundColor = [UIColor colorWithWhite:0.204 alpha:1.000];
    }

    // código de prueba, a implementar aún.
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self selectMenuPIE:indexPath menuShow:[self.tabBarController selectedIndex]];
    self.navigationController.viewControllers = @[self.contentViewController];
    self.frostedViewController.contentViewController = self.navigationController;
    [self.frostedViewController hideMenuViewController];
}


/**
 *  Setup cell for menu
 *
 *  @param indexPath element
 *  @param cell      cell
 */
-(void)makeMenu{
    if ([self.tabBarController selectedIndex] == 0) {
        self.navigationController =     [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
        self.menuList = @[kmenuHome_2,kmenuHome_3,kmenuHome_4];
    }else if([self.tabBarController selectedIndex] == 1){
        self.navigationController =     [self.storyboard instantiateViewControllerWithIdentifier:@"contentControllerArtist"];
        self.menuList = @[kmenuArtista_1,kmenuArtista_2,kmenuArtista_3,kmenuArtista_4,kmenuArtista_5,kmenuArtista_6,kmenuArtista_7,kmenuArtista_8];
    }else if([self.tabBarController selectedIndex] == 2){
        self.navigationController =     [self.storyboard instantiateViewControllerWithIdentifier:@"contentControllerVisit"];
        self.menuList = @[kmenuVisitaAntes,kmenuVisitaDespues];
    }else if([self.tabBarController selectedIndex] == 3){
        self.navigationController =     [self.storyboard instantiateViewControllerWithIdentifier:@"contentControllerAccesible"];
        self.menuList = @[kmenuAccesibilidadNino, kmenuAccesibilidadReducidaMov,kmenuAccesibilidadReducidaVisual,kmenuAccesibilidadReducidaAudio];
    }
    menuSelect =[self.tabBarController selectedIndex];
    [self.tableView reloadData];
}

/**
 *  HAce la accion de pulsar en menú de PIE, le paso el valor del menú seleccionado y el index path para saber que elemento del menú se ha pulsado
 *
 *  @param indexPath indexPath
 */

-(void)selectMenuPIE:(NSIndexPath *)indexPath menuShow:(NSInteger)menu{
    NSInteger idSelect = indexPath.row;
    switch (menu) {
        case 0:{
            PIEHomeViewController *pieHome = (PIEHomeViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
            pieHome.idSelectMenu = idSelect;
            self.contentViewController = pieHome;
            break;
        }
        case 1:{
            PIEArtistsViewController *artistHome = (PIEArtistsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"homeControllerArtist"];
            artistHome.idSelectMenu = idSelect;
            self.contentViewController = artistHome;
            break;
        }
        case 2:{
            PIEVisitViewController *visitHome = [self.storyboard instantiateViewControllerWithIdentifier:@"homeControllerVisit"];
            visitHome.idSelectMenu = idSelect;
            self.contentViewController = visitHome;
            break;
        }
        case 3:{
            PIEAccessibilityViewController *accessHome = [self.storyboard instantiateViewControllerWithIdentifier:@"accesible"];
            accessHome.idSelectMenu = idSelect;
            self.contentViewController = accessHome;
        }
            break;
        default:
            break;
    }    
}


#pragma mark -tabbar DELEGATE
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewControlle{
    menuSelect = tabBarController.selectedIndex;
    [self viewWillAppear:NO];
}
@end
