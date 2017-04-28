//
//  AcronymExpansion.m
//  acronymSearch
//
//  Created by Mario Meraz on 4/27/17.
//  Copyright © 2017 Mario Meraz. All rights reserved.
//

#import "AcronymExpansion.h"

@implementation AcronymExpansion

static NSString *const LONG_FORM_JSON_KEY = @"lf";
static NSString *const VARIATIONS_LIST_JSON_KEY = @"vars";

- (void)setVariationsFrom:(NSArray<NSDictionary *> *)variationsArray{
  NSMutableString *buffer = [[NSMutableString  alloc] init];
  NSInteger finalOne = [variationsArray count];
  NSInteger index = 0;
  for (NSDictionary *variationDictionary in variationsArray) {
    NSString *variation = [variationDictionary valueForKey:LONG_FORM_JSON_KEY];
    if (index < finalOne - 1){
      buffer = [NSMutableString stringWithFormat:@"%@%@, ", buffer, variation];
    }else{
      buffer = [NSMutableString stringWithFormat:@"%@%@", buffer, variation];
    }
    index ++;
  }
  self.variations = buffer;
}

+ (AcronymExpansion *)objectFromJSON:(NSDictionary *)json{
  AcronymExpansion *newObject = [[AcronymExpansion alloc] init];
  [newObject setLongForm:[json valueForKey: LONG_FORM_JSON_KEY]];
  [newObject setVariationsFrom:[json valueForKey:VARIATIONS_LIST_JSON_KEY]];
  return newObject;
}
@end
