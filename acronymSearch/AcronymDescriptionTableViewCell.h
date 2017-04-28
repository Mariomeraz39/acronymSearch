//
//  AcronymDescriptionTableViewCell.h
//  acronymSearch
//
//  Created by Mario Meraz on 4/27/17.
//  Copyright © 2017 Mario Meraz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcronymDescriptionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *longFormLabel;
@property (weak, nonatomic) IBOutlet UILabel *variationsLabel;

@end
