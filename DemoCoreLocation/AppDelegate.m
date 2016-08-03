//
//  AppDelegate.m
//  DemoCoreLocation
//
//  Created by ASPL on 7/26/16.
//  Copyright © 2016 ASPL. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"


@interface AppDelegate ()<CLLocationManagerDelegate>{
    
    UIApplication *app;
    CLLocationManager *locationManager;
    __block UIBackgroundTaskIdentifier bgTask;
    NSTimer *timer;
    CLLocation *location;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    app = [UIApplication sharedApplication];
    locationManager = [ViewController sharedLocationManager];
    
    [self startLocationManager];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [locationManager stopUpdatingLocation];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    locationManager.pausesLocationUpdatesAutomatically = NO;
    locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    [locationManager startUpdatingLocation];
    
    NSLog(@"backgroundTimeRemaining: %.0f", [[UIApplication sharedApplication] backgroundTimeRemaining]);
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

-(void)applicationWillEnterForeground:(UIApplication *)application{
    
}

-(void)stopBackgroundTask{
    
    [timer invalidate];
    
    [app endBackgroundTask:bgTask];
    bgTask = UIBackgroundTaskInvalid;
    
    
    NSLog(@"Background Task Stopped !!!");
    
}

-(void)startBackgroundTask{
    
        bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                      target:self
                                                    selector:@selector(startTrackingBg)
                                                    userInfo:nil
                                                     repeats:YES];
    
}

-(void)startTrackingBg {
    
    [locationManager startUpdatingLocation];
    
    NSLog(@"Background Task Running !!! Location : %f,%f",locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude);
    
    if(location){
        
        NSLog(@"Last Updated Location : %f,%f",location.coordinate.latitude,location.coordinate.longitude);
    }
    
    
    //Call method to send location on server here
    // ...
    
}

- (void)startLocationManager{
    
        //set delegate
        locationManager.delegate = self;

        // This is the most important property to set for the manager. It ultimately determines how the manager will
        // attempt to acquire location and thus, the amount of power that will be consumed.

        if ([locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)]) {
            [locationManager setAllowsBackgroundLocationUpdates:YES];
        }
        [locationManager requestAlwaysAuthorization];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isBackgroundON"] isEqualToString:@"YES"]){
 
        // Once configured, the location manager must be "started".
        [locationManager startUpdatingLocation];
        
        [self startBackgroundTask];
    }
    
}


#pragma mark - Location Manager Delegates

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    if ([locations count]>0) {
        location = [locations lastObject];
    }
    
//    NSLog(@"\nLatitude: %f\nLongitude:%f",location.coordinate.latitude,location.coordinate.longitude);
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"Location manager failed with error: %@",error.description);
}



@end
