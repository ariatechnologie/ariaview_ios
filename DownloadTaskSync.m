//
//  DownloadTaskSync.m
//  test
//
//  Created by BOUSSAADIA AMIR on 16/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadTaskSync.h"

@implementation DownloadTaskSync

- (NSInteger)executeRequest:(NSString*) url : (NSString*) pathToWrite_  {
    pathToWrite = pathToWrite_;
    NSURL *stringToUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:stringToUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    NSURLResponse* response;
    NSError* error = nil;
    
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[responseData length]);
    [self writeInFile:responseData];
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    
    return [httpResponse statusCode];
}

- (NSInteger)executeRequest:(NSString*) url : (NSString*) login : (NSString*) password : (NSString*) libelleSite : (NSString*) pathToWrite_ {
    pathToWrite = pathToWrite_;
    NSURL *stringToUrl = [NSURL URLWithString:url];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:stringToUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    NSString *post = [NSString stringWithFormat:@"login=%@&password=%@&site=%@", login, password, libelleSite];

    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];

    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLResponse* response;
    NSError* error = nil;
    
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[responseData length]);
    [self writeInFile:responseData];
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    
    return [httpResponse statusCode];

}

/*
 * Return the code response
 */
- (NSInteger)executeRequest:(NSString*) url : (NSString*) login : (NSString*) password : (NSString*) pathToWrite_  {
    pathToWrite = pathToWrite_;
    NSURL *stringToUrl = [NSURL URLWithString:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:stringToUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    NSString *post = [NSString stringWithFormat:@"login=%@&password=%@", login, password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLResponse* response;
    NSError* error = nil;
    
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[responseData length]);
    [self writeInFile:responseData];
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    
    return [httpResponse statusCode];
}

-(void)writeInFile:(NSData *)content {
    NSString *txt = [[NSString alloc] initWithData:responseData encoding: NSASCIIStringEncoding];
    NSData* data = [txt dataUsingEncoding:NSUTF8StringEncoding];
    NSFileManager *filemgr = [[NSFileManager alloc] init];
    [filemgr createFileAtPath: pathToWrite contents: data attributes: nil];
    data = [filemgr contentsAtPath: pathToWrite ];
    reponseEncode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}


@end