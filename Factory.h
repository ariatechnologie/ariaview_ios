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
#import "Filtre.h"
#import "FBEncryptorAES.h"
#import "NSData+Base64.h"

@interface Factory : NSObject {
    NSString *pathToWriteSaveLogin;
    
    @public
    
    NSString *messageRememberConnection, *messageConnexionError, *titleConnexionError,*messageAuthError, *titleAuthError,
    *messageWebServiceDownError, *titleWebServiceDownError, *messageTechnicalError,
    *titleTechnicalError, *messageNoDateError, *titleNoDateError, *messageNoSiteError,
    *titleNoSiteError, *messageNoPollutantError, *titleNoPollutantError, *titleMenuSite,
    *titleMenuDate, *titleMenuPollutant, *titleMenuSignout, *titleHeaderAuthent, *titleHeaderSite,
    *titleHeaderDate, *titleHeaderPollutant, *titleHeaderPollution, *titleHeaderInterval,
    *loginLabelText, *passwordLabelText, *connexionButtonText, *menuButtonText;
}
+ (void)removeFile;
+(NSString*) getNameFileSaveLogin;
+(NSString*) getPathToWriteSaveLogin;
+(User*) getSaveLogin;
+(void) uncreateSaveLogin;
+(void) createSaveLogin:(User*) user;
+(void)writeInFile:(NSData *)content : (NSString*) nameFile;
-(id) initWithLanguage:(int) indexLanguage;
+ (BOOL) getConnectionState;
+ (void) alertMessage : (NSString*) title : (NSString*) message : (UIViewController*) delegate;
+ (NSString*) getFormatSelectionDateString: (NSDate*) dateStart : (NSDate*) dateEnd;
+ (NSDate*) getDateFromFormatKml: (NSString*) date;
@end

#endif
