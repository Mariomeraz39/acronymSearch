//
//  Networking.m
//  acronymSearch
//
//  Created by Mario Meraz on 4/27/17.
//  Copyright © 2017 Mario Meraz. All rights reserved.
//

#import "Networking.h"
#import "AcronymExpansion.h"
#import <AFNetworking.h>
// Wrapper class for AFNetworking to handle network operations.
@implementation Networking
// Location of API endpoint to make acronym/initialism requests.
static NSString *const API_URL = @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=";

+ (instancetype)sharedInstance {
  static Networking *sharedInstance = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    sharedInstance = [[Networking alloc] init];
  });
  return sharedInstance;
}

- (void)requestMeaningFor:(NSString *)shorthand withCallback:(CallbackBlock)callback{
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
  // Append the string we want to search for.
  NSString *queryURL = [NSString stringWithFormat:@"%@%@", API_URL, shorthand];
  // Since server sends content-type as text/plain, we need to make it acceptable to receive it.
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
  
  [manager GET:queryURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    // We get a single object array so we get the actual dictionary here.
    if ([responseObject count] > 0) {
      NSDictionary *dict = responseObject[0];
      // Then we get the variations dictionaries.
      NSArray *variationsArray = dict[@"lfs"];
      NSMutableArray *expansionList = [[NSMutableArray alloc] initWithCapacity:[variationsArray count]];
      // We go through each and ask the AcronymExpansion class to create objects to fill our array with.
      for (NSDictionary *dict in variationsArray) {
        [expansionList addObject:[AcronymExpansion objectFromJSON:dict]];
      }
      // We finally pass the obtained and formatted information through the callback.
      callback(expansionList);
    }else{
      callback([[NSMutableArray alloc] init]);
    }
  } failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
  }];
  
}

@end
