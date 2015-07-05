//
//  ScreenOverlay.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 10/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_ScreenOverlay_h
#define AriaViewIOS_ScreenOverlay_h

@interface ScreenOverlay : NSObject {
    @public
    NSString *name, *iconPath, *unitsOverlay, *unitScreen, *unitSize;
    double overLayX, overLayY, screenX, screenY, sizeX, sizeY;
}

@end

#endif
