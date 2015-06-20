//
//  XmlToObjectParser.m
//  test
//
//  Created by BOUSSAADIA AMIR on 15/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLToObjectParser.h"
#import "ListTagXml.h"

@implementation XMLToObjectParser

- (ListTagXml *)items
{
    return items;
}

/*
 * Build the KML structure into a variable of type "AirModelXml"
 */
- (AirModelXml*) parseKml:(ListTagXml*) kmlContent {
    AirModelXml* airModelXml = [[AirModelXml alloc] init];
    
    /*
     * Data about Document
     */
    ListTagXml *document = [kmlContent->tags objectAtIndex:0];
    airModelXml->name = ((ListTagXml*)[document->tags objectAtIndex:0])->content;
    airModelXml->visibility = [((ListTagXml*)[document->tags objectAtIndex:1])->content intValue];
    airModelXml->myPollutants = [[NSMutableArray alloc] init];
    
    /*
     * Data about Folder root (pollutants)
     */
    for(int o = 2; o < [document->tags count];o++) {
        Pollutant *pollutant = [[Pollutant alloc] init];
        
        ListTagXml *folderRoot = [document->tags objectAtIndex:o];
        pollutant->name = ((ListTagXml*)[folderRoot->tags objectAtIndex:0])->content;
        pollutant->visibility = [((ListTagXml*)[folderRoot->tags objectAtIndex:1])->content intValue];
        
        /*
         * Data about ScreenOverlay
         */
        NSString *nameAttributesX = @"x";
        NSString *nameAttributesY = @"y";
        NSString *nameAttributesUnits = @"xunits";
        ListTagXml *screenOverlay = ((ListTagXml*)[folderRoot->tags objectAtIndex:2]);
        
        pollutant->screenOverLay = [[ScreenOverlay alloc] init];
        pollutant->screenOverLay->name = ((ListTagXml*)[screenOverlay->tags objectAtIndex:0])->content;
        pollutant->screenOverLay->iconPath = ((ListTagXml*)[((ListTagXml*)[screenOverlay->tags objectAtIndex:1])->tags objectAtIndex:0])->content;
      
        NSLog(@"%@=%@", pollutant->name, pollutant->screenOverLay->iconPath);
        
        ListTagXml *overLayXY = ((ListTagXml*)[screenOverlay->tags objectAtIndex:2]);
        pollutant->screenOverLay->overLayX = [(NSString*)[overLayXY->attributes objectForKey:nameAttributesX] doubleValue];
        pollutant->screenOverLay->overLayY = [(NSString*)[overLayXY->attributes objectForKey:nameAttributesY] doubleValue];
        pollutant->screenOverLay->unitsOverlay = (NSString*)[overLayXY->attributes objectForKey:nameAttributesUnits];
        ListTagXml *screenXY = ((ListTagXml*)[screenOverlay->tags objectAtIndex:3]);
        pollutant->screenOverLay->screenX = [(NSString*)[screenXY->attributes objectForKey:nameAttributesX] intValue];
        pollutant->screenOverLay->screenY = [(NSString*)[screenXY->attributes objectForKey:nameAttributesY] intValue];
        pollutant->screenOverLay->unitScreen = (NSString*)[screenXY->attributes objectForKey:nameAttributesUnits];
        ListTagXml *size = ((ListTagXml*)[screenOverlay->tags objectAtIndex:4]);
        pollutant->screenOverLay->sizeX = [(NSString*)[size->attributes objectForKey:nameAttributesX] doubleValue];
        pollutant->screenOverLay->sizeY = [(NSString*)[size->attributes objectForKey:nameAttributesY] doubleValue];
        pollutant->screenOverLay->unitSize= (NSString*)[size->attributes objectForKey:nameAttributesUnits];
        
        /*
         * Data about Second folder
         */
        ListTagXml *secondFolder = ((ListTagXml*)[folderRoot->tags objectAtIndex:3]);
        pollutant->polutionInterval = [[PolutionInterval alloc] init];
        pollutant->polutionInterval->name = ((ListTagXml*)[secondFolder->tags objectAtIndex:0])->content;
        pollutant->polutionInterval->visibility = [((ListTagXml*)[secondFolder->tags objectAtIndex:1])->content intValue];
        
        pollutant->polutionInterval->groundOverLayList = [[NSMutableArray alloc] init];
        
        for(int i = 2; i < [secondFolder->tags count];i++) {
            
            /*
             * Data about GroundOverLay
             */
            ListTagXml *groundOverLay = (ListTagXml*)[secondFolder->tags objectAtIndex:i];
            GroundOverLay *groundOverLayModel = [[GroundOverLay alloc] init];
            groundOverLayModel->name = ((ListTagXml*)[groundOverLay->tags objectAtIndex:0])->content;
            
            // Icon
            ListTagXml *iconGroundOverLay = (ListTagXml*)[groundOverLay->tags objectAtIndex:1];
            groundOverLayModel->iconPath = ((ListTagXml*)[iconGroundOverLay->tags objectAtIndex:0])->content;
            
            groundOverLayModel->iconViewBoundScale = [((ListTagXml*)[iconGroundOverLay->tags objectAtIndex:1])->content doubleValue];
            
            // LatLongBox
            
            ListTagXml *latLongBox = (ListTagXml*)[groundOverLay->tags objectAtIndex:2];
            groundOverLayModel->latLongNorth = [((ListTagXml*)[latLongBox->tags objectAtIndex:0])->content doubleValue];
            groundOverLayModel->latLongSouth = [((ListTagXml*)[latLongBox->tags objectAtIndex:1])->content doubleValue];
            groundOverLayModel->latLongEast = [((ListTagXml*)[latLongBox->tags objectAtIndex:2])->content doubleValue];
            groundOverLayModel->latLongWest = [((ListTagXml*)[latLongBox->tags objectAtIndex:3])->content doubleValue];
            
            // TimeStamp
            // Example format = "2013-02-23T01:30:00+01:00"
            ListTagXml *timeStamp = (ListTagXml*)[groundOverLay->tags objectAtIndex:3];
            NSString *timeStampStartNotFormated = ((ListTagXml*)[timeStamp->tags objectAtIndex:0])->content;
            NSString *timeStampEndNotFormated = ((ListTagXml*)[timeStamp->tags objectAtIndex:1])->content;
            groundOverLayModel->timeStampBegin = [Factory getDateFromFormatKml:timeStampStartNotFormated];
            groundOverLayModel->timeStampEnd = [Factory getDateFromFormatKml:timeStampEndNotFormated];
            
            // Add GroundOverLay into list
            [pollutant->polutionInterval->groundOverLayList addObject:groundOverLayModel];
        }
        
        [airModelXml->myPollutants addObject:pollutant];
        
    }
    
    return airModelXml;
}

- (id) parseXml:(NSData*) xmlContent parseError:(NSError **)error{
    
    NSString* xmlToNSString = [[NSString alloc] initWithData:xmlContent encoding:NSUTF8StringEncoding];
    
    // remove tabulation and new line
    NSString *xmlWithoutSpace;
    xmlWithoutSpace = [xmlToNSString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    xmlWithoutSpace = [xmlWithoutSpace stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    xmlWithoutSpace = [xmlWithoutSpace stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    xmlWithoutSpace = [xmlWithoutSpace stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    xmlContent = [xmlWithoutSpace dataUsingEncoding:NSUTF8StringEncoding];
    
    // init data
    isRoot = true;
    currentNodeContent = [[NSMutableString alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlContent];
    [parser setDelegate:self];
    [parser parse]; // parse the document
    
    if([parser parserError] && error) {
        *error = [parser parserError];
    }

    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    
    ListTagXml *itemTmp = [[ListTagXml alloc] init];
    itemTmp->name = [elementName copy];
    itemTmp->attributes = [attributeDict copy];
    itemTmp->tags = [[NSMutableArray alloc] init];
    
    if (isRoot) {
        items = itemTmp;
        root = itemTmp;
        isRoot = false;
    } else {
        itemTmp->up = items;
        [items->tags addObject:itemTmp];
        items = itemTmp;
    }
//    NSLog(@"open tag: %@ items tag: %@", elementName, items);
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
//    NSLog(@"items tag: %@ Close tag: %@", items, elementName);
    items = items->up;
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    NSString *found = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([found length] > 0) {
        if (!items->content) {
            items->content = [[NSMutableString alloc] init];
        }
        [items->content appendString:string];
    }
}


@end