//
//  ShotModel.h
//  Badsmells
//
//  Created by Thiago Lioy on 1/21/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
@interface ShotModel : MTLModel<MTLJSONSerializing>
@property(nonatomic,strong) NSString *title;
@end
