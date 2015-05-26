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
//    self = [super init];
    if(self)
    {
        NSLog(@"initWithFiltre");
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
    
    NSLog(@"viewDidLoad");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"numberOfSectionsInTableView");
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath");
    if([Factory getConnectionState ]) {
        /*
         * Pollutant selection must to exist in table
         */
        if (filtre->site->myPollutants != nil && [filtre->site->myPollutants objectAtIndex:(int)indexPath] != nil) {
            filtre->indexPollutant = (int)indexPath;
            //  init view and set data
            
            UIViewController_SW *mapView = [[self.storyboard instantiateViewControllerWithIdentifier:@"SWGoogleMapView"] initWithData:filtre];
            
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