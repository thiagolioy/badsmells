//
//  DribbleClient.h
//  Badsmells
//
//  Created by Thiago Lioy on 1/21/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SucessBlock)(NSArray *shots);
@interface DribbleClient : NSObject

+ (instancetype)sharedClient;
-(void)fetchShots:(SucessBlock)block;
@end
