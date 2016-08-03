//
//  AppDelegate.h
//  DemoCoreLocation
//
//  Created by ASPL on 7/26/16.
//  Copyright © 2016 ASPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)startBackgroundTask;
-(void)stopBackgroundTask;

@end

