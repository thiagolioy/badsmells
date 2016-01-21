//
//  ShotTableViewCell.m
//  Badsmells
//
//  Created by Thiago Lioy on 1/21/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "ShotTableViewCell.h"
#import "ShotModel.h"

@interface ShotTableViewCell ()
@property(nonatomic,weak)IBOutlet UILabel *label1;
@property(nonatomic,weak)IBOutlet UILabel *label2;
@end

@implementation ShotTableViewCell

-(void)setup:(ShotModel*)object{
    self.label1.text = object.title;
}

@end
