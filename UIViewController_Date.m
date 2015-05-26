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
    infosXML = @"infos.xml";
    path = @"/tmp/ariaview/";
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
//        NSLog(@"root: %@", root->tags);
        ListTagXml *xmlParsed = [root->tags objectAtIndex:indexDates];
//        NSLog(@"Count: %lu", (unsigned long)[xmlParsed->tags count]);
        for(int i = 0; i < [xmlParsed->tags count]; i++) {
            ListTagXml *tag = [xmlParsed->tags objectAtIndex:i];
//            NSLog(@"Libelle: %@", tag->content);
            [liste addObject:tag->content];
        }
        // save dates in filter
        filtre->site->myDates = [liste copy];
    } else
        [Factory alertMessage:factory->titleNoDateError:factory->messageNoDateError:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get site selected
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *date = cell.textLabel.text;
    
    if([Factory getConnectionState ]) {
        // Create url to get infos and create file path where will be stored data
        DownloadTaskSync *downloadTask = [[DownloadTaskSync alloc] init];
        NSMutableString *path_to_log = [[NSMutableString alloc] init];
        // Build structure url
        NSMutableString *pathDirectory  = [[NSMutableString alloc] init];
        [pathDirectory appendString:@"http://web.aria.fr/awa/destination/ARIAVIEW/"];
        [pathDirectory appendString:filtre->site->libelle];
        [pathDirectory appendString:@"/GEARTH/RESULT_LcS/"];
        NSString *dateForUrl = (NSString*)[filtre->site->myDates objectAtIndex:indexPath.row];
        [pathDirectory appendString:dateForUrl];
        [pathDirectory appendString:@"/"];
        [path_to_log appendString:pathDirectory];
        [path_to_log appendString:dateForUrl];
        [path_to_log appendString:@".kml"];
        NSLog(@"Connecting to %@", path_to_log);
        
        NSMutableString *path_to_storage = [[NSMutableString alloc] init];
        [path_to_storage appendString:path];
        [path_to_storage appendString:infosXML];
//        NSLog(@"path_to_storage in %@", path_to_storage);

        // Download the xml content, to get infos about polution
        [downloadTask executeRequest:path_to_log:path_to_storage];
        XMLToObjectParser *myParser = [XMLToObjectParser alloc];
        [myParser parseXml:downloadTask->responseData parseError:nil];
        AirModelXml* airModelXml = [myParser parseKml:myParser->root];
        
        /*
         * Big condition, but at least, every data must to be ok
         * At least one pollutant and one pollutant sky
         */
        if (airModelXml != nil && airModelXml->myPollutants != nil && [airModelXml->myPollutants count] > 0 && ((Pollutant*)[airModelXml->myPollutants objectAtIndex:0])->polutionInterval != nil && ((Pollutant*)[airModelXml->myPollutants objectAtIndex:0])->polutionInterval->groundOverLayList != nil && [((Pollutant*)[airModelXml->myPollutants objectAtIndex:0])->polutionInterval->groundOverLayList count] > 0) {
            
            filtre->date = date;
            filtre->site->urlDirectory = pathDirectory;
            filtre->site->modelKml = airModelXml;
            filtre->site->myPollutants = [airModelXml->myPollutants copy];
            
//         init view and set data in table
            UIViewController_Pollutant *pollutantView = [[self.storyboard instantiateViewControllerWithIdentifier:@"TableViewPollutant"] initWithFiltre:filtre];

            [self.navigationController pushViewController:pollutantView animated:YES];
        } else {
            [Factory alertMessage:factory->titleNoDateError:factory->messageNoDateError:self];
        }
    } else {
        [Factory alertMessage:factory->titleConnextionError:factory->messageConnextionError:self];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filtre->site->myDates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSString *date = (NSString*)[filtre->site->myDates objectAtIndex:indexPath.row];
    
    NSString *year, *month, *day;
    year = [date substringToIndex:4];
    month = [[date substringToIndex:6] substringFromIndex:4];
    day = [date substringFromIndex:6];
   
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    [dc setYear:[year integerValue]];
    [dc setMonth:[month integerValue]];
    [dc setDay:[day integerValue]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ / %@ / %@", day, month, year];
    
    return cell;
    
}

@end