//
//  ViewController.m
//  acronymSearch
//
//  Created by Mario Meraz on 4/27/17.
//  Copyright © 2017 Mario Meraz. All rights reserved.
//

#import "ViewController.h"
#import "Networking.h"
#import <MBProgressHUD.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end

@implementation ViewController

- (AcronymDescriptionTableViewCell *)dummyCell{
  if (!_dummyCell) {
    _dummyCell = [self.descriptionTable dequeueReusableCellWithIdentifier:@"acronymDescriptionCell"];
  }
  return _dummyCell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.longDescriptions = [[NSMutableArray alloc] init];

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    [self.descriptionTable reloadData];
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)executeSearch:(UIButton *)sender {

  NSString *queryText = [self.searchField text];
  // Show the progress HUD
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  
  [[Networking sharedInstance] requestMeaningFor:queryText withCallback: ^void (NSMutableArray *array){
    dispatch_async(dispatch_get_main_queue(), ^{
      self.longDescriptions = array;
      [self.descriptionTable reloadData];
      // After data has been reloaded, hide the progress HUD
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // It's dispatched in a different thread so that the UI keeps on being responsive.
        dispatch_async(dispatch_get_main_queue(), ^{
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
      });
    });
  }];

}


@end
