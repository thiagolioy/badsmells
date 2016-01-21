//
//  ViewController.m
//  Badsmells
//
//  Created by Thiago Lioy on 1/21/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "ViewController.h"
#import "DribbleClient.h"
#import <libextobjc/EXTScope.h>
@interface ViewController ()
@property(nonatomic,weak)IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchShotsCount];
}

-(void)fetchShotsCount{
    @weakify(self);
    [[DribbleClient sharedClient] fetchShots:^(NSArray *shots) {
        @strongify(self);
        [self updateShotsCountLabel:shots.count];
    }];
}

-(void)updateShotsCountLabel:(NSUInteger)count{
    self.label.text = [NSString stringWithFormat:@"Number of shots: %@",@(count).stringValue];
}

@end
