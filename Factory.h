//
//  Factory.h
//  test
//
//  Created by BOUSSAADIA AMIR on 28/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_Factory_h
#define test_Factory_h

#import <UIKit/UIKit.h>

@interface Factory : NSObject {
    @public
    NSString *messageConnextionError;
    NSString *titleConnextionError;
    NSString *messageAuthError;
    NSString *titleAuthError;
    NSString *messageWebServiceDownError;
    NSString *titleWebServiceDownError;
    NSString *messageTechnicalError;
    NSString *titleTechnicalError;
    NSString *messageNoDateError;
    NSString *titleNoDateError;
    NSString *messageNoSiteError;
    NSString *titleNoSiteError;
}

+ (BOOL) getConnectionState;
+ (void) alertMessage : (NSString*) title : (NSString*) message : (UIViewController*) delegate;

@end

#endif
