//
//  Coordinate.m
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 28/06/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

@implementation Coordinate

- (id) initWithData: (NSDate*) x : (double) y {
    if(self) {
        self->xValue = x;
        self->yValue = y;
    }
    return self;
}

@end
