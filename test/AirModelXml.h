//
//  AirModelXml.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 10/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_AirModelXml_h
#define AriaViewIOS_AirModelXml_h
#import "ScreenOverLay.h"
#import "PolutionInterval.h"
#import "Pollutant.h"

@interface AirModelXml : NSObject {
    @public
    NSString *name;
    int visibility;
    NSMutableArray *myPollutants;
}


@end

#endif
