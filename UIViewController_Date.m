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
    NSLog(@"viewDidLoad UIViewController_Date");
    [myTable setDataSource:self];
    [myTable setDelegate:self];
}

// Create array from content xml
- (void) createDates:(NSData*) xmlContent {
    NSLog(@"createDates UIViewController_Date");

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
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
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
    cell.textLabel.text = date;
    
    return cell;
    
}

@end