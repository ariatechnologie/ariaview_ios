//
//  Coordinate.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 28/06/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_Coordinate_h
#define AriaViewIOS_Coordinate_h

@interface Coordinate : NSObject {
    @public
    NSDate *xValue;
    double yValue;
}

- (id) initWithData: (NSDate*) x : (double) y;

@end

#endif
