//
//  ViewController2.m
//  Badsmells
//
//  Created by Thiago Lioy on 1/21/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "ViewController2.h"
#import <AFNetworking.h>
#import "ShotTableViewCell.h"
#import "ShotModel.h"
#import <TSMessage.h>

@interface ViewController2 ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)IBOutlet UITableView *tableview1;
@property(nonatomic,strong)NSArray *shots;
@end

static NSString *cellId = @"ShotTableViewCell";
@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *params = @{@"page": [NSNumber numberWithInteger:1]};
    NSString *acessToken = @"951320fc6f069e9f2b8f25201f504eca56caa29aa5c90d67237fa37fad8dee5b";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", acessToken] forHTTPHeaderField:@"Authorization"];
    
    [manager GET:@"https://api.dribbble.com/v1/shots" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response : %@",responseObject);
        
        
        ShotModel *model = [MTLJSONAdapter modelOfClass:ShotModel.class
                         fromJSONDictionary:[((NSArray*)responseObject) objectAtIndex:0]
                                      error:nil];
        
        [TSMessage showNotificationWithTitle:model.title
                                        type:TSMessageNotificationTypeWarning];

        
        self.shots = (NSArray*)responseObject;
        self.tableview1.delegate = self;
        self.tableview1.dataSource = self;
        [self.tableview1 reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shots.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    NSDictionary *dc = [self.shots objectAtIndex:indexPath.row];
    
    cell.label1.text = [dc valueForKey:@"title"];
    if(indexPath.row %2 == 0)
        [cell.label1 setTintColor:[UIColor greenColor]];
    else
        [cell.label1 setTintColor:[UIColor redColor]];
    return cell;
}

@end
