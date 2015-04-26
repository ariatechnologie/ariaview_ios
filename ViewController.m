//
//  ViewController.m
//  test
//
//  Created by BOUSSAADIA AMIR on 31/03/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import "ViewController.h"
#import "DownloadTaskSync.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    path = @"/tmp/ariaview/";
    urlBouchon = @"https://raw.githubusercontent.com/ariatechnologie/ariaview_android/master/testFile";
    url = @"";
    loginXML = @"login.xml";
    
    ariaDirectory = [NSFileManager defaultManager];
    
    if ([ariaDirectory fileExistsAtPath: path ] == YES)
        NSLog (@"Directory exists");
    else {
        if(![ariaDirectory createDirectoryAtPath:path attributes:nil])
            NSLog(@"Error: Create folder failed %@", ariaDirectory);
        else
             NSLog(@"Directory created");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onKeyLogin:(UITextField *)sender {
     login = sender.text;
}

- (IBAction)onKeyPassword:(UITextField *)sender {
     password = sender.text;
}

- (IBAction)onClick:(id)sender {
    DownloadTaskSync *downloadTask = [[DownloadTaskSync alloc] init];
    NSMutableString *path_to_log = [[NSMutableString alloc] init];
    // [path_to_log appendString:url];
    [path_to_log appendString:urlBouchon];
    [path_to_log appendString:@"/"];
    [path_to_log appendString:loginXML];
    NSLog(@"Connecting to %@", path_to_log);
    NSMutableString *path_to_storage = [[NSMutableString alloc] init];
    [path_to_storage appendString:path];
    [path_to_storage appendString:loginXML];
    NSLog(@"path_to_storage in %@", path_to_storage);
    // [downloadTask executeRequest:path_to_log :login:password:path_to_storage];
    
    // Download the xml content, to get sites from account(login/password)
    [downloadTask executeRequest:path_to_log :path_to_storage];
    
    // init view and set data in table
    UIViewController_Site *viewArraySite = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewSite"];
    [viewArraySite createLocations:downloadTask->responseData];
    [self.navigationController pushViewController:viewArraySite animated:YES];
}
@end
