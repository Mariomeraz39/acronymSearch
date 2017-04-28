//
//  AcronymExpansion.h
//  acronymSearch
//
//  Created by Mario Meraz on 4/27/17.
//  Copyright © 2017 Mario Meraz. All rights reserved.
//

#import <Foundation/Foundation.h>

// Class to hold the information obtained from the server
@interface AcronymExpansion : NSObject
  @property (strong, nonatomic) NSString *longForm;
  @property (strong, nonatomic) NSString *variations;

  // Used to parse and set the class string 'variations' from the array of variations found in
  // the JSON object.
  - (void)setVariationsFrom:(NSArray<NSString *> *)variationsArray;

  // Takes a JSON dictionary and parses it to create a new instane of this class.
  + (AcronymExpansion *)objectFromJSON:(NSDictionary *)json;

@end
