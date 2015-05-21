//
//  ListTagXml.h
//  test
//
//  Created by BOUSSAADIA AMIR on 25/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_ListTagXml_h
#define test_ListTagXml_h

@interface ListTagXml : NSObject {
    @public
    ListTagXml *up;
    NSString *name;
    NSMutableArray *tags;
    NSDictionary *attributes;
    NSString *content;
}
    
@end

#endif
