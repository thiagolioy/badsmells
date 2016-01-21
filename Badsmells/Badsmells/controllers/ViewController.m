//
//  ViewController.m
//  Badsmells
//
//  Created by Thiago Lioy on 1/21/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking.h>

@interface ViewController ()
@property(nonatomic,weak)IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *params = @{@"page": [NSNumber numberWithInteger:1]};
    NSString *acessToken = @"951320fc6f069e9f2b8f25201f504eca56caa29aa5c90d67237fa37fad8dee5b";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", acessToken] forHTTPHeaderField:@"Authorization"];
    
    [manager GET:@"https://api.dribbble.com/v1/shots" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *a = (NSArray*)responseObject;
        NSLog(@"response : %@",responseObject);
        self.label.text = [NSString stringWithFormat:@"Number of pages:%lu",(unsigned long)a.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
