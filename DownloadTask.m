//
//  DownloadTask.m
//  test
//
//  Created by BOUSSAADIA AMIR on 09/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import "DownloadTask.h"

@implementation DownloadTask


- (void)executeRequest:(NSString*) url : (NSString*) pathToWrite_  {
    pathToWrite = pathToWrite_;
    NSURL *stringToUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:stringToUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)writeInFile:(NSData *)content {
    NSString *txt = [[NSString alloc] initWithData:responseData encoding: NSASCIIStringEncoding];
    NSData* data = [txt dataUsingEncoding:NSUTF8StringEncoding];
    NSFileManager *filemgr = [[NSFileManager alloc] init];
    [filemgr createFileAtPath: pathToWrite contents: data attributes: nil];
    data = [filemgr contentsAtPath: pathToWrite ];
    reponseEncode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)executeRequest:(NSString*) url : (NSString*) login : (NSString*) password : (NSString*) pathToWrite_  {
    pathToWrite = pathToWrite_;
    NSURL *stringToUrl = [NSURL URLWithString:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:stringToUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:@"user", login,
                              @"password", password, nil];
    NSData *postData = [self encodeDictionary:postDict];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Unable to fetch data error %@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[responseData length]);
    [self writeInFile:responseData];
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