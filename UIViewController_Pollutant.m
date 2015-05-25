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

- (id)initWithFiltre:(Filtre*) _filtre {
    self = [super init];
    if(self)
    {
        filtre = _filtre;
    }
    return self;
}

- (void) viewDidLoad {
    infosXML = @"infos.xml";
    path = @"/tmp/ariaview/";
    [myTable setDataSource:self];
    [myTable setDelegate:self];
    factory = [[Factory alloc] init];
    self.navigationItem.hidesBackButton = YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([Factory getConnectionState ]) {
        /*
         * Pollutant selection must to exist in table
         */
        if (filtre->site->myPollutant != nil && [filtre->site->myPollutant objectAtIndex:(int)indexPath] != nil) {
            
            //  init view and set data
            UIViewController_SW *mapView = [[self.storyboard instantiateViewControllerWithIdentifier:@"SWGoogleMapView"] initWith:0:filtre:(int)indexPath];
            
            [self.navigationController pushViewController:mapView animated:YES];
        } else {
            [Factory alertMessage:factory->titleNoDateError:factory->messageNoDateError:self];
        }
    } else {
        [Factory alertMessage:factory->titleConnextionError:factory->messageConnextionError:self];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filtre->site->myPollutant count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Pollutant *pollutant = (Pollutant*)[filtre->site->myPollutant objectAtIndex:indexPath.row];

    cell.textLabel.text = pollutant->name;
    
    return cell;
    
}

@end