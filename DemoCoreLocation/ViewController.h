//
//  ViewController.h
//  DemoCoreLocation
//
//  Created by ASPL on 7/26/16.
//  Copyright © 2016 ASPL. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class AppDelegate;

@interface ViewController : UIViewController

+ (CLLocationManager *)sharedLocationManager;
+ (id)sharedInstance;

@end

