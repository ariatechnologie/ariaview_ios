//
//  Factory.m
//  test
//
//  Created by BOUSSAADIA AMIR on 28/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Factory.h"
#import "Reachability.h"

@implementation Factory

-(id) initWithLanguage:(int) indexLanguage
{
    self = [super init];
    if(self)
    {
        pathToWriteSaveLogin = @"";
        
        /*
         * 0 = French
         * 1 = English
         */
        
        NSArray *languages = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Languages"];
        NSDictionary *language = [languages objectAtIndex:indexLanguage];
        
        messageConnexionError = [language objectForKey:@"messageConnexionError"];
        titleConnexionError = [language objectForKey:@"titleConnexionError"];
        messageAuthError = [language objectForKey:@"messageAuthError"];
        titleAuthError = [language objectForKey:@"titleAuthError"];
        messageWebServiceDownError = [language objectForKey:@"messageWebServiceDownError"];;
        titleWebServiceDownError = [language objectForKey:@"titleWebServiceDownError"];
        messageTechnicalError = [language objectForKey:@"messageTechnicalError"];
        titleTechnicalError = [language objectForKey:@"titleTechnicalError"];
        messageNoSiteError = [language objectForKey:@"messageNoSiteError"];
        titleNoSiteError = [language objectForKey:@"titleNoSiteError"];
        messageNoDateError = [language objectForKey:@"messageNoDateError"];
        titleNoDateError = [language objectForKey:@"titleNoDateError"];
        messageNoPollutantError = [language objectForKey:@"messageNoPollutantError"];
        titleNoPollutantError = [language objectForKey:@"titleNoPollutantError"];
        
        /*
         * Title remeber
         */
        messageRememberConnection = [language objectForKey:@"messageRememberConnection"];
        
        /*
         * Title menu
         */
        titleMenuSite = [language objectForKey:@"titleMenuSite"];
        titleMenuDate = [language objectForKey:@"titleMenuDate"];
        titleMenuPollutant = [language objectForKey:@"titleMenuPollutant"];
        titleMenuSignout = [language objectForKey:@"titleMenuSignout"];
        
        /*
         * Title UIView
         */
        titleHeaderAuthent = [language objectForKey:@"titleHeaderAuthent"];
        titleHeaderSite = [language objectForKey:@"titleHeaderSite"];
        titleHeaderDate = [language objectForKey:@"titleHeaderDate"];
        titleHeaderPollutant = [language objectForKey:@"titleHeaderPollutant"];
        titleHeaderPollution = [language objectForKey:@"titleHeaderPollution"];
        titleHeaderInterval = [language objectForKey:@"titleHeaderInterval"];
        
        /*
         *  Authentification
         */
        loginLabelText = [language objectForKey:@"loginLabelText"];
        passwordLabelText = [language objectForKey:@"passwordLabelText"];
        connexionButtonText = [language objectForKey:@"connexionButtonText"];
        
        /*
         *  SW Slide out menu
         */
        menuButtonText = @"Menu";
    }
    return self;
}

+ (BOOL) getConnectionState {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return false;
    } else {
        return true;
    }
}

+ (void) alertMessage : (NSString*) title : (NSString*) message : (UIViewController*) delegate {
    //  init view and set text error
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: title
                                                   message: message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert setTag:1];
    [alert show];
}

+ (NSString*) getFormatSelectionDateString: (NSDate*) dateStart : (NSDate*) dateEnd {
    NSString *label;
    if(dateStart != nil || dateEnd != nil) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateStart];
        NSInteger hourStart = [components hour];
        NSInteger minuteStart = [components minute];
        components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateEnd];
        NSInteger hourEnd = [components hour];
        NSInteger minuteEnd = [components minute];
        NSString *hourStartString, *minuteStartString, *hourEndString, *minuteEndString;
        
        if(hourStart >= 0 && hourEnd >= 0 && minuteStart >= 0 && minuteEnd >= 0 &&
           hourStart <= 24 && hourEnd <= 24 && minuteStart <= 60 && minuteEnd <= 60) {
        /*
         * Add 0 if number have just one number because format is date
         */
        if(hourStart >= 0 && hourStart < 10)
            hourStartString = [NSString stringWithFormat:@"0%ld", (long)hourStart];
        else
            hourStartString = [NSString stringWithFormat:@"%ld", (long)hourStart];
        if(hourEnd >= 0 && hourEnd < 10)
            hourEndString = [NSString stringWithFormat:@"0%ld", (long)hourEnd];
        else
            hourEndString = [NSString stringWithFormat:@"%ld", (long)hourEnd];
        
        if(minuteStart >= 0 && minuteStart < 10)
            minuteStartString = [NSString stringWithFormat:@"0%ld", (long)minuteStart];
        else
            minuteStartString = [NSString stringWithFormat:@"%ld", (long)minuteStart];
        if(minuteEnd >= 0 && minuteEnd < 10)
            minuteEndString = [NSString stringWithFormat:@"0%ld", (long)minuteEnd];
        else
            minuteEndString = [NSString stringWithFormat:@"%ld", (long)minuteEnd];
        
        label = [NSString stringWithFormat:@"[%@:%@ - %@:%@]", hourStartString, minuteStartString, hourEndString, minuteEndString];
        }
        
    }
    
    return label;
}

+ (NSDate*) getDateFromFormatKml: (NSString*) date {
    // Example format = "2013-02-23T01:30:00+01:00"
    int year, month, day, hours, minuts, seconds;
    year = [[date substringToIndex:4] intValue];
    month = [[[date substringToIndex:7] substringFromIndex:5] intValue];
    day = [[[date substringToIndex:10] substringFromIndex:8] intValue];
    hours = [[[date substringFromIndex:11] substringToIndex:2] intValue];
    minuts = [[[date substringFromIndex:14] substringToIndex:2] intValue];
    seconds = [[[date substringFromIndex:17] substringToIndex:2] intValue];
    
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    [dc setYear:year];
    [dc setMonth:month];
    [dc setDay:day];
    [dc setHour:hours];
    [dc setMinute:minuts];
    [dc setSecond:seconds];
    
    double time = [[[NSCalendar currentCalendar] dateFromComponents:dc] timeIntervalSince1970];
    
    return [NSDate dateWithTimeIntervalSince1970:time];
}

+(NSString*) getPathToWriteSaveLogin {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/ariaview/"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    
    NSString *filePath = [dataPath stringByAppendingPathComponent:@"connexion.xml"];
    
    return filePath;
}

+(User*) getSaveLogin {
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[self getPathToWriteSaveLogin]];
    
    if(!fileExists)
        return nil;
    
    NSData* data;
    NSFileManager *filemgr = [[NSFileManager alloc] init];
    data = [filemgr contentsAtPath: [self getPathToWriteSaveLogin] ];
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray* foo = [content componentsSeparatedByString: @";"];
    
    User *u = [User alloc];
    u->login = [foo objectAtIndex: 0];
    u->password = [foo objectAtIndex: 1];
    
    return u;
}

+(void) createSaveLogin:(User*) user {
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[self getPathToWriteSaveLogin]];
    
    if(fileExists)
        [self uncreateSaveLogin];
    
    NSMutableString *content = [[NSMutableString alloc] init];
    [content appendString:user->login];
    [content appendString:@";"];
    [content appendString:user->password];
    
    NSData* dataResult = [[NSString stringWithString:content] dataUsingEncoding:NSUTF8StringEncoding];
    
    [self writeInFile:dataResult];
    
}

+(void)uncreateSaveLogin {
    [self removeFile];
}

+ (void)removeFile
{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager removeItemAtPath:[self getPathToWriteSaveLogin] error:&error];
    if (!success) {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

+(void)writeInFile:(NSData *)content {
    NSError *error;
    NSString *txt = [[NSString alloc] initWithData:content encoding: NSASCIIStringEncoding];
    [txt writeToFile:[self getPathToWriteSaveLogin] atomically:YES
            encoding:NSUTF8StringEncoding error:&error];
//    NSLog(@"%@", error);
}

@end