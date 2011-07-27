//
//  MainViewController.h
//  bootsoundmanager
//
//  Created by Vladislav on 27.07.11.
//  Copyright 2011 Tigr@Soft. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *tableVw;
}


- (IBAction)showInfo:(id)sender;
- (IBAction)about:(id)sender;

@end
