//
//  UIViewController_Date.m
//  test
//
//  Created by BOUSSAADIA AMIR on 23/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController_Date.h"

@interface UIViewController_Date ()
@end

@implementation UIViewController_Date

- (void) viewDidLoad {
    [myTable setDataSource:self];
    [myTable setDelegate:self];
    factory = [[Factory alloc] init];
    self.navigationItem.hidesBackButton = YES;
}

// Create array from content xml
- (void) createDates:(NSData*) xmlContent {
    NSMutableArray* liste = [[NSMutableArray alloc] init];
    XMLToObjectParser *myParser = [XMLToObjectParser alloc];
    [myParser parseXml:xmlContent parseError:nil];
    
    ListTagXml *root = myParser->root;
    
    NSInteger indexDates = 3;
    
    if(root != nil && [root->tags objectAtIndex:indexDates] != nil) {
        NSLog(@"root: %@", root->tags);
        
        ListTagXml *xmlParsed = [root->tags objectAtIndex:indexDates];
        
        NSLog(@"Count: %lu", (unsigned long)[xmlParsed->tags count]);
        
        for(int i = 0; i < [xmlParsed->tags count]; i++) {
            ListTagXml *tag = [xmlParsed->tags objectAtIndex:i];
            
            NSLog(@"Libelle: %@", tag->content);
            
            [liste addObject:tag->content];
        }
        myDates = [liste copy];
    } else
        [Factory alertMessage:factory->titleNoDateError:factory->messageNoDateError:self];
    // save dates in filter
    filtre->site->myDates = [myDates copy];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Get site selected
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *date = cell.textLabel.text;
    
    // init view and set data in table
    UIViewController_SW *mapView = [self.storyboard instantiateViewControllerWithIdentifier:@"SWGoogleMapView"];
    filtre->date = date;
    mapView->filtre = filtre;
    [self.navigationController pushViewController:mapView animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myDates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSString *date = (NSString*)[myDates objectAtIndex:indexPath.row];
    
    NSString *year, *month, *day;
    year = [date substringToIndex:4];
    month = [[date substringToIndex:6] substringFromIndex:4];
    day = [date substringFromIndex:6];
   
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    [dc setYear:[year integerValue]];
    [dc setMonth:[month integerValue]];
    [dc setDay:[day integerValue]];
//    NSDate *dateFormat = [dc date];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ / %@ / %@", day, month, year];
    
    return cell;
    
}

@end