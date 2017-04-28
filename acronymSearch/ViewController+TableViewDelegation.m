//
//  ViewController+TableViewDelegation.m
//  acronymSearch
//
//  Created by Mario Meraz on 4/27/17.
//  Copyright © 2017 Mario Meraz. All rights reserved.
//

#import "ViewController+TableViewDelegation.h"


@implementation ViewController (TableViewDelegation)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [self.longDescriptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  AcronymDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acronymDescriptionCell" forIndexPath:indexPath];
  [self configureCell:cell forRowAtIndexPath:indexPath];
  return cell;
}

- (void)configureCell:(AcronymDescriptionTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

  if ([self.longDescriptions count] > 0 ){ // don't try to get values if none have been fetched yet.
    AcronymExpansion *cellDescription = self.longDescriptions[indexPath.row];
    
    [cell.longFormLabel setText: cellDescription.longForm];
    [cell.variationsLabel setText: cellDescription.variations];
    
  }
}

- (CGFloat) heightForLabel:(UILabel *)label{

  CGRect screenRect = [[UIScreen mainScreen] bounds];
  CGFloat screenWidth = screenRect.size.width;

  CGSize constraint = CGSizeMake(screenWidth - 139, CGFLOAT_MAX); // -139 due to other label width and hspacing
  CGSize size;
  NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:label.font}
                                                context:context].size;
  
  size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
//  NSLog(@"Height calculated [%f]", size.height);
  
  return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

  [self configureCell:self.dummyCell forRowAtIndexPath:indexPath];
  [self.dummyCell layoutIfNeeded];
  CGFloat finalWidth = 0;
  CGFloat heightBuffer = 0;
  UILabel *first = self.dummyCell.longFormLabel;
  UILabel *second = self.dummyCell.variationsLabel;
  heightBuffer = [self heightForLabel:first];
  heightBuffer = heightBuffer + [self heightForLabel:second];
  
  CGSize size = CGSizeMake(finalWidth, heightBuffer);

  return size.height+1 + 24 ; // +1 for cell separator +24 for the margins and vspace
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return UITableViewAutomaticDimension;
}

@end
