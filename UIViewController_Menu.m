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
    factory = [[Factory alloc] initWithLanguage:filtre->indexLanguage];
    //set const var
    CHANGE_SITE = 0; CHANGE_DATE = 1; CHANGE_POLLUTANT = 2; SIGNOUT = 3;
    // set options from slide out menu
    myOptions = [[NSMutableArray alloc] init];
    [myOptions addObject:factory->titleMenuSite];
    [myOptions addObject:factory->titleMenuDate];
    [myOptions addObject:factory->titleMenuPollutant];
    [myOptions addObject:factory->titleMenuSignout];
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
    
    if(filtre == nil) {
        
        if(indexPath.row != SIGNOUT) {
            [Factory alertMessage:factory->titleTechnicalError:factory->messageTechnicalError:self];
        }
        
        //  Init view
        UIViewController_Auth *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        
        [self.navigationController pushViewController:mainView animated:YES];
        
    } else {
        
    if(filtre != nil) {
        filtre->indexInterval = 0;
        filtre->site->markers = [[NSMutableArray alloc] init];
    }
        
    if(indexPath.row == CHANGE_SITE) {
        
        // reinit filtre
        filtre->site = nil;
        filtre->date = nil;
        
        //  Init view and set data in table
        UIViewController_Site *viewArraySite = [[self.storyboard instantiateViewControllerWithIdentifier:@"TableViewSite"] initWithFiltre:filtre:false];
        
        [self.navigationController pushViewController:viewArraySite animated:YES];
        
    } else if(indexPath.row == CHANGE_DATE) {
        
        // reinit filtre and set it to the new view
        filtre->date = nil;
       
        //  Init view and set data in table
        UIViewController_Date *viewDates = [[self.storyboard instantiateViewControllerWithIdentifier:@"TableViewDate"] initWithFiltre:filtre :false];
        
        [self.navigationController pushViewController:viewDates animated:YES];
        
    } else if(indexPath.row == SIGNOUT) {
        
        //  Init view
        UIViewController_Auth *mainView = [[self.storyboard instantiateViewControllerWithIdentifier:@"MainView"] initWithFiltre:filtre];
        
        [self.navigationController pushViewController:mainView animated:YES];
        
    }
    else if (indexPath.row == CHANGE_POLLUTANT) {
        //  Init view and set data in table
        UIViewController_Pollutant *pollutantView = [[self.storyboard instantiateViewControllerWithIdentifier:@"TableViewPollutant"] initWithFiltre:filtre:false];
        
        [self.navigationController pushViewController:pollutantView animated:YES];
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
    
    if(indexPath.row == CHANGE_SITE) {
       cell.imageView.image = [UIImage imageNamed:@"multi-site.png"];
    } else if(indexPath.row == CHANGE_DATE) {
        cell.imageView.image = [UIImage imageNamed:@"calendar.png"];
    } else if(indexPath.row == SIGNOUT) {
        cell.imageView.image = [UIImage imageNamed:@"deconnexion.png"];
    }
    else if (indexPath.row == CHANGE_POLLUTANT) {
        cell.imageView.image = [UIImage imageNamed:@"biohazard.png"];
    }

    CGSize itemSize = CGSizeMake(26, 26);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell;

}

@end