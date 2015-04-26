//
//  DownloadTask.h
//  test
//
//  Created by BOUSSAADIA AMIR on 09/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_DownloadTask_h
#define test_DownloadTask_h
#import <Foundation/Foundation.h>

@interface DownloadTask : NSObject {
    @public NSMutableData *responseData;
    @protected
    NSString* pathToWrite;
    NSString* reponseEncode;
}

- (void)executeRequest:(NSString*) url : (NSString*) pathToWrite_;
- (void)executeRequest:(NSString*) url : (NSString*) login : (NSString*) password : (NSString*) pathToWrite_ ;
- (NSData*)encodeDictionary:(NSDictionary*)dictionary;
-(void)writeInFile:(NSData*) content;

@end

#endif
