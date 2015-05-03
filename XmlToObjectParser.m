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
//        NSLog(@"found caractere c: %@ items tag: %@", string, items);
        items->content = string;
    }
}


@end