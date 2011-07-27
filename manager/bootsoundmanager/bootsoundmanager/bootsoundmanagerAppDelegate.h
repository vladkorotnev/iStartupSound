//
//  bootsoundmanagerAppDelegate.h
//  bootsoundmanager
//
//  Created by Vladislav on 27.07.11.
//  Copyright 2011 Tigr@Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface bootsoundmanagerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end
