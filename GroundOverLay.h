
//
//  GroundOverLay.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 10/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_GroundOverLay_h
#define AriaViewIOS_GroundOverLay_h

@interface GroundOverLay : NSObject {
    @public
    NSString *name, *iconPath;
    double iconViewBoundScale, latLongNorth, latLongSouth, latLongEast, latLongWest;
    NSDate *timeStampBegin, *timeStampEnd;
}

@end
#endif
