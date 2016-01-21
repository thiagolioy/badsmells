//
//  ViewController2.m
//  Badsmells
//
//  Created by Thiago Lioy on 1/21/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "ViewController2.h"
#import "ShotTableViewCell.h"
#import "ShotModel.h"
#import <TSMessage.h>
#import "DribbleClient.h"
#import <libextobjc/EXTScope.h>

@interface ViewController2 ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)IBOutlet UITableView *tableview1;
@property(nonatomic,strong)NSArray *shots;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchShots];
}

-(void)fetchShots{
    @weakify(self);
    [[DribbleClient sharedClient] fetchShots:^(NSArray *shots) {
        @strongify(self);
        self.shots = shots;
        [self sendShotsMessage];
        [self updateTableView];
    }];
}

-(void)sendShotsMessage{
    ShotModel *model = self.shots.firstObject;
    [TSMessage showNotificationWithTitle:model.title
                                    type:TSMessageNotificationTypeWarning];

}

-(void)updateTableView{
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [self.tableview1 reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shots.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShotTableViewCell cellIdentifier] forIndexPath:indexPath];
    ShotModel *shot = [self.shots objectAtIndex:indexPath.row];
    [cell setup:shot];
    return cell;
}

@end
