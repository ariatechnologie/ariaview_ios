//
//  Pollutant.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 25/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_Pollutant_h
#define AriaViewIOS_Pollutant_h
#import "ScreenOverlay.h"
#import "PolutionInterval.h"

@interface Pollutant : NSObject {
    @public
    ScreenOverlay *screenOverLay;
    PolutionInterval *polutionInterval;
    NSString *name;
    int visibility;
}
@end

#endif
