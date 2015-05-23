//
//  XMLToObjectParser.h
//  test
//
//  Created by BOUSSAADIA AMIR on 15/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_XMLToObjectParser_h
#define test_XMLToObjectParser_h

#import <Foundation/Foundation.h>
#import "ListTagXml.h"
#import "AirModelXml.h"
#import "Factory.h"

@interface XMLToObjectParser : NSObject <NSXMLParserDelegate> {
    NSString *className;
    NSString *currentNodeName;
    NSMutableString *currentNodeContent;
    BOOL isRoot;
    @public
    ListTagXml *items; // stands for any class
    ListTagXml *root; // stands for any class

}
- (NSArray *)items;
- (NSMutableArray*) parseXml:(NSData*) xmlContent parseError:(NSError **)error;
- (AirModelXml*) parseKml:(ListTagXml*) kmlContent;

@end

#endif
