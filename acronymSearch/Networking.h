//
//  Networking.h
//  acronymSearch
//
//  Created by Mario Meraz on 4/27/17.
//  Copyright © 2017 Mario Meraz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CallbackBlock)(NSMutableArray *);

@interface Networking : NSObject

+ (instancetype)sharedInstance;
- (void)requestMeaningFor:(NSString *)shorthand withCallback:(CallbackBlock )callback;

@end
