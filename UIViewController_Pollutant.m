//
//  UIViewController_Pollutant.m
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 25/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController_Pollutant.h"

@implementation UIViewController_Pollutant

- (id)initWithFiltre:(Filtre*) _filtre:(BOOL)_isFirstTime {
    if(self)
    {
        filtre = _filtre;
        isFirstTime = _isFirstTime;
        infosXML = @"infos.xml";
        path = @"/tmp/ariaview/";
        factory = [[Factory alloc] initWithLanguage:filtre->indexLanguage];
    }
    return self;
}

- (void) viewDidLoad {
    
    [myTable setDataSource:self];
    [myTable setDelegate:self];
    navBar.title = factory->titleHeaderPollutant;
    self.navigationItem.hidesBackButton = YES;
    
    if(isFirstTime) {
        [self process:[NSIndexPath indexPathForRow:0 inSection:0]];
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"numberOfSectionsInTableView");
    return 1;
}

-(void) process:(NSIndexPath*)_indexPath {
    NSLog(@"didSelectRowAtIndexPath");
    if([Factory getConnectionState ]) {
        /*
         * Pollutant selection must to exist in table
         */
        NSLog(@"%@", _indexPath);
        if (filtre->site->myPollutants != nil && [filtre->site->myPollutants count] > (int)_indexPath.row && [filtre->site->myPollutants objectAtIndex:(int)_indexPath.row] != nil) {
            filtre->indexPollutant = (int)_indexPath.row;
            //  init view and set data
            
            UIViewController_SW *mapView = [[self.storyboard instantiateViewControllerWithIdentifier:@"SWGoogleMapView"] initWithFiltre:filtre];
            
            [self.navigationController pushViewController:mapView animated:YES];
            
        } else {
            [Factory alertMessage:factory->titleNoDateError:factory->messageNoDateError:self];
        }
    } else {
        [Factory alertMessage:factory->titleConnexionError:factory->messageConnexionError:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self process:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    return [filtre->site->myPollutants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Pollutant *pollutant = (Pollutant*)[filtre->site->myPollutants objectAtIndex:indexPath.row];
    
    cell.textLabel.text = pollutant->name;
    
    NSLog(@"cellForRowAtIndexPath");
    
    return cell;
    
}

@end