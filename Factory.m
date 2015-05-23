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

-(id) init
{
    self = [super init];
    if(self)
    {
        messageConnextionError = @"Connexion internet non fonctionnelle, vérifier votre connexion.";
        titleConnextionError = @"Etat connexion";
        messageAuthError = @"Les identifiants saisis sont incorrectes.";
        titleAuthError = @"Authentification";
        messageWebServiceDownError = @"Impossible d'atteindre le serveur, veuillez réessayer ultérieurement.";
        titleWebServiceDownError = @"Web service";
        messageTechnicalError = @"Une erreur technique est survenue, veuillez réessayer ultérieurement.";
        titleTechnicalError = @"Web service";
        messageNoSiteError = @"Il n'existe pas de site repertorié pour votre compte.";
        titleNoSiteError = @"Avertissement";
        messageNoDateError = @"Il n'existe pas d'historisation de poluant pour ce site.";
        titleNoDateError = @"Avertissement";

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
        
        if(hourStart >= 0 && hourEnd >= 0 && minuteStart > 0 && minuteEnd >= 0 &&
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
        
        label = [NSString stringWithFormat:@"[%@ H %@ - %@ H %@]", hourStartString, minuteStartString, hourEndString, minuteEndString];
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

@end