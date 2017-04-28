//
//  ViewController.h
//  acronymSearch
//
//  Created by Mario Meraz on 4/27/17.
//  Copyright © 2017 Mario Meraz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcronymDescriptionTableViewCell.h"
#import "AcronymExpansion.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *descriptionTable;
@property (strong, nonatomic) NSMutableArray  *longDescriptions;

// We hold a dummy cell to calculate cell height dynamically.
@property (strong, nonatomic) AcronymDescriptionTableViewCell *dummyCell;

@end

