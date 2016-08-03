//
//  ViewController.m
//  DemoCoreLocation
//
//  Created by ASPL on 7/26/16.
//  Copyright © 2016 ASPL. All rights reserved.
//
#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController (){
    
    __weak IBOutlet UILabel *lblStatus;
    __weak IBOutlet UIButton *btnToggleTracking;
    
    
    
    BOOL isTrackingON;
    CLLocationManager *locationManager;
    UIApplication *app;
    AppDelegate *appDelegate;
   }

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    app = [UIApplication sharedApplication];
    appDelegate =(AppDelegate *) [app delegate];
    locationManager = [ViewController sharedLocationManager];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isBackgroundON"] isEqualToString:@"YES"]){
        isTrackingON = YES;
        btnToggleTracking.backgroundColor = [UIColor greenColor];
        [btnToggleTracking setTitle:@"Stop !!!" forState:UIControlStateNormal];
        lblStatus.text = @"Tracking Started !!!";
        
    }
    
    btnToggleTracking.selected = isTrackingON;
    
}


- (IBAction)toggleTracking:(id)sender {
    
    btnToggleTracking.selected = !btnToggleTracking.selected;
    
    btnToggleTracking.isSelected?[self startTracking]:[self stopTracking];
    
}

- (void)startTracking{
    
    isTrackingON = YES;
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isBackgroundON"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"started Tracking");
    lblStatus.text = @"Tracking Started !!!";
    [btnToggleTracking setTitle:@"Stop !!!" forState:UIControlStateNormal];
    [btnToggleTracking setBackgroundColor:[UIColor greenColor]];
    
    [locationManager startUpdatingLocation];
    
    [appDelegate startBackgroundTask];
}

- (void)stopTracking{
    
    isTrackingON = NO;
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isBackgroundON"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"stop Tracking");
    lblStatus.text = @"Tracking Stopped !!!";
    [btnToggleTracking setTitle:@"Start !!!" forState:UIControlStateNormal];
    [btnToggleTracking setBackgroundColor:[UIColor orangeColor]];
    
    [locationManager stopUpdatingLocation];
    
    [appDelegate stopBackgroundTask];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (CLLocationManager *)sharedLocationManager{
    static dispatch_once_t once;
    static CLLocationManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[CLLocationManager alloc] init];
    });
    
    return sharedInstance;
}

+ (id)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}



@end
