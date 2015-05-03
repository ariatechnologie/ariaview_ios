//
//  DownloadTaskSync.h
//  test
//
//  Created by BOUSSAADIA AMIR on 16/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_DownloadTaskSync_h
#define test_DownloadTaskSync_h

@interface DownloadTaskSync : NSObject {
@public NSData *responseData;
@protected
    NSString* pathToWrite;
    NSString* reponseEncode;
}
- (NSInteger)executeRequest:(NSString*) url : (NSString*) pathToWrite_;
- (NSInteger)executeRequest:(NSString*) url : (NSString*) login : (NSString*) password : (NSString*) pathToWrite_ ;
- (NSInteger)executeRequest:(NSString*) url : (NSString*) login : (NSString*) password : (NSString*) libelleSite : (NSString*) pathToWrite_;
- (NSData*)encodeDictionary:(NSDictionary*)dictionary;
-(void)writeInFile:(NSData*) content;

@end

#endif
