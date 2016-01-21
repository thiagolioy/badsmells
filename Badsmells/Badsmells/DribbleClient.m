//
//  DribbleClient.m
//  Badsmells
//
//  Created by Thiago Lioy on 1/21/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "DribbleClient.h"
#import <AFNetworking.h>
#import "ShotModel.h"
#import <TSMessage.h>


NSString* const kAccessToken = @"951320fc6f069e9f2b8f25201f504eca56caa29aa5c90d67237fa37fad8dee5b";
@interface DribbleClient ()
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@end

@implementation DribbleClient

static DribbleClient *_sharedInstance = nil;
+ (instancetype)sharedClient {
    static DribbleClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (AFHTTPRequestOperationManager *)manager{
    if (!_manager) {
        _manager =  [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://api.dribbble.com/v1/"]];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self setupCustomHeadersForManager:_manager];
    }
    return _manager;
}

-(void)setupCustomHeadersForManager:(AFHTTPRequestOperationManager*)manager{
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", kAccessToken]
                     forHTTPHeaderField:@"Authorization"];
}


-(void)fetchShots:(SucessBlock)block{
    NSDictionary *params = @{@"page": [NSNumber numberWithInteger:1]};
    [self.manager GET:@"shots" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self handleSuccessResponse:responseObject successBlock:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)handleSuccessResponse:(id)responseObj successBlock:(SucessBlock)block{
    NSError *error = nil;
    NSArray *models =  [ShotModel parseArray:responseObj error:&error];
    if(models)
        block(models);
    else
        [self handleParseError];
}

-(void)handleParseError{
    [TSMessage showNotificationWithTitle:@"Parse error" type:TSMessageNotificationTypeError];
}

@end
