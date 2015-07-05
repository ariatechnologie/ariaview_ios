//
//  PolutionInterval.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 10/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_PolutionInterval_h
#define AriaViewIOS_PolutionInterval_h

#import "GroundOverLay.h"

@interface PolutionInterval : NSObject {
    @public
    NSString *name;
    int visibility;
    NSMutableArray *groundOverLayList;
}

@end

#endif
