//
//  UIViewController_Site.m
//  test
//
//  Created by BOUSSAADIA AMIR on 15/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import "UIViewController_Site.h"

@interface UIViewController_Site ()

@end

@implementation UIViewController_Site

- (void) viewDidLoad {
    urlStub = @"https://raw.githubusercontent.com/ariatechnologie/ariaview_android/master/testFile";
    url = @"http://web.aria.fr/webservices/ARIAVIEW/infosite.php";
    datesXML = @"dates.xml";
    infosXML = @"infos.xml";
    path = @"/tmp/ariaview/";
    // Hide previous button
    self.navigationItem.hidesBackButton = YES;
    factory = [[Factory alloc] init];
    [myTable setDataSource:self];
    [myTable setDelegate:self];
}

- (void) createLocations:(NSData*) xmlContent {
    NSMutableArray* liste = [[NSMutableArray alloc] init];
    XMLToObjectParser *myParser = [XMLToObjectParser alloc];
    [myParser parseXml:xmlContent parseError:nil];
    ListTagXml *root = myParser->root;
    NSInteger indexSites = 1;
    
    if(root != nil && [root->tags objectAtIndex:indexSites] != nil) {
//      NSLog(@"root: %@", root->tags);
        ListTagXml *xmlParsed = [root->tags objectAtIndex:indexSites];
//      NSLog(@"Count: %lu", (unsigned long)[xmlParsed->tags count]);
        for(int i = 0; i < [xmlParsed->tags count]; i++) {
            Site *site = [[Site alloc] init];
            ListTagXml *tag = [xmlParsed->tags objectAtIndex:i];
            [site setLibelle:tag->content];
//          NSLog(@"Libelle: %@", [site libelle]);
            [liste addObject:site];
        }
        myLocations = [liste copy];
    } else {
        [Factory alertMessage:factory->titleNoSiteError:factory->messageNoSiteError:self];
    }
    // save locations in filter
    filtre->user->myLocations = [myLocations copy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([Factory getConnectionState ]) {
        // Create url to get infos and create file path where will be stored data
        DownloadTaskSync *downloadTask = [[DownloadTaskSync alloc] init];
        NSMutableString *path_to_log = [[NSMutableString alloc] init];
        // [path_to_log appendString:url];
        [path_to_log appendString:url];
//        NSLog(@"Connecting to %@", path_to_log);
        NSMutableString *path_to_storage = [[NSMutableString alloc] init];
        [path_to_storage appendString:path];
        [path_to_storage appendString:infosXML];
//        NSLog(@"path_to_storage in %@", path_to_storage);
       
        // Get site selected
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *cellText = cell.textLabel.text;
        
        Site *siteSelected = [myLocations objectAtIndex:indexPath.row];
        
        // Download the xml content, to get infos from site
        NSInteger error = [downloadTask executeRequest:path_to_log :filtre->user->login:filtre->user->password:cellText:path_to_storage];
        
    //  Parse the xml content
    //    <?xml version='1.0' encoding='utf-8'?>
    //    <result>
    //        <host>http://web.aria.fr</host>
    //        <url>awa/destination/ARIAVIEW</url>
    //        <datefile>dates.xml</datefile>
    //        <model>RESULT</model>
    //        <site>JUAREZ</site>
    //        <nest>LcS</nest>
    //    </result>
        
        XMLToObjectParser *myParser = [XMLToObjectParser alloc];
        [myParser parseXml:downloadTask->responseData parseError:nil];
        
        ListTagXml *root = myParser->root;
        
    //    NSLog(@"root %@", root);
    //    NSLog(@"root->tags %@", root->tags);
    //    NSLog(@"root->tags count %lu", (unsigned long)[root->tags count]);
        
    //    ListTagXml *res =[root->tags objectAtIndex:0];
        
    //    NSLog(@"res %@", res);
    //    NSLog(@"res content %@", res->content);
    //    NSLog(@"res->tags %@", res->tags);
    //    NSLog(@"res->tags count %lu", (unsigned long)[res->tags count]);

        NSInteger numberOfElements = 6;
        NSInteger indexHost = 0, indexUrl = 1, indexDate = 2, indexModel = 3, indexNest = 5;
        
        if(error == 200 && root != nil && root->tags != nil && [root->tags count] >= numberOfElements) {
            ListTagXml *hostParsed = [root->tags objectAtIndex:indexHost];
            ListTagXml *urlParsed = [root->tags objectAtIndex:indexUrl];
            ListTagXml *dateParsed = [root->tags objectAtIndex:indexDate];
            ListTagXml *modelParsed = [root->tags objectAtIndex:indexModel];
            ListTagXml *nestParsed = [root->tags objectAtIndex:indexNest];
            
            NSString *hote = hostParsed->content;
            NSString *urlAriaView = urlParsed->content;
            NSString *dateFile = dateParsed->content;
            NSString *model = modelParsed->content;
            NSString *nest = nestParsed->content;
        
//            NSLog(@"hote %@, url %@, dateFile %@, model %@, nest %@", hote, urlAriaView, dateFile, model, nest);
            
            // create url
            path_to_log = [[NSMutableString alloc] init];
            [path_to_log appendString:hote];
            [path_to_log appendString:@"/"];
            [path_to_log appendString:urlAriaView];
            [path_to_log appendString:@"/"];
            [path_to_log appendString:cellText];
            [path_to_log appendString:@"/GEARTH/"];
            [path_to_log appendString:model];
            [path_to_log appendString:@"_"];
            [path_to_log appendString:nest];
            [path_to_log appendString:@"/"];
            [path_to_log appendString:dateFile];
        
//            NSLog(@"Connecting to %@", path_to_log);
            path_to_storage = [[NSMutableString alloc] init];
            [path_to_storage appendString:path];
            [path_to_storage appendString:datesXML];
//            NSLog(@"path_to_storage in %@", path_to_storage);
        
            // Download the xml content, to get dates from site
            error = [downloadTask executeRequest:path_to_log :path_to_storage];

            if(error == 200 && [downloadTask->responseData length] > 0) {
                // init view and set data in table
                UIViewController_Date *viewArrayDate = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewDate"];
                // Set filtre (data)
                filtre->site = siteSelected;
                viewArrayDate->filtre = filtre;
                
                [viewArrayDate createDates:downloadTask->responseData];
                [self.navigationController pushViewController:viewArrayDate animated:YES];
            } else {
                [Factory alertMessage:factory->titleTechnicalError:factory->messageTechnicalError:self];
            }
        } else {
            [Factory alertMessage:factory->titleTechnicalError:factory->messageTechnicalError:self];
        }
    } else {
        [Factory alertMessage:factory->titleConnextionError:factory->messageConnextionError:self];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myLocations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Site *site = (Site*)[myLocations objectAtIndex:indexPath.row];
    cell.textLabel.text = [site libelle];
    
    return cell;
    
}

@end
