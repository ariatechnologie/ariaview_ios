//
//  UIViewController_Menu.m
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 02/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController_Menu.h"

@implementation UIViewController_Menu

-(void) viewDidLoad {
    factory = [[Factory alloc] init];
    //set const var
    CHANGE_SITE = 0; CHANGE_DATE = 1; SIGNOUT = 2;
    // set options from slide out menu
    myOptions = [[NSMutableArray alloc] init];
    [myOptions addObject:@"Modifier le site"];
    [myOptions addObject:@"Modifier la date"];
    [myOptions addObject:@"Deconnexion"];
    // set date source and listenner(this class)
    [tableViewMenu setDataSource:self];
    [tableViewMenu setDelegate:self];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", filtre);
    NSLog(@"%@", filtre->site);
    NSLog(@"%@", filtre->user);
    NSLog(@"%@", filtre->date);
    
    if(filtre == nil || filtre->site == nil || filtre->user == nil || filtre->date == nil) {
        
        if(indexPath.row == SIGNOUT) {
            
            //  Init view and set data in table
            ViewController *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
            
            [self.navigationController pushViewController:mainView animated:YES];
            
        } else {
            [Factory alertMessage:factory->titleTechnicalError:factory->messageTechnicalError:self];
        }
        
    } else {
        
    if(indexPath.row == CHANGE_SITE) {
        
        //  Init view and set data in table
        UIViewController_Site *viewArraySite = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewSite"];
        
        // reinit filtre
        filtre->site = nil;
        filtre->date = nil;
        viewArraySite->filtre = filtre;
        viewArraySite->myLocations = filtre->user->myLocations;
        
        [self.navigationController pushViewController:viewArraySite animated:YES];
        
    } else if(indexPath.row == CHANGE_DATE) {
        
        //  Init view and set data in table
        UIViewController_Date *viewDates = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewDate"];
        
        // reinit filtre and set it to the new view
        filtre->date = nil;
        viewDates->filtre = filtre;
        viewDates->myDates = filtre->site->myDates;
        
        [self.navigationController pushViewController:viewDates animated:YES];
        
    } else if(indexPath.row == SIGNOUT) {
        
        //  Init view and set data in table
        ViewController *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        
        [self.navigationController pushViewController:mainView animated:YES];
        
    }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *option = (NSString*)[myOptions objectAtIndex:indexPath.row];
    
    cell.textLabel.text = option;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
    
}

@end