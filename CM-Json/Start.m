//
//  ViewController.m
//  CM-Json
//
//  Created by Walter Gonzalez Domenzain on 11/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Start.h"
@import GoogleMaps;

#define nUagLat 20.695306
#define nUagLng -103.418190

@interface Start ()

@end

@implementation Start

- (void)viewDidLoad {
    [super viewDidLoad];
    mstTemp = [[NSString alloc] init];
    mstTempMax = [[NSString alloc] init];
    mstTempMin = [[NSString alloc] init];
    mstPressure = [[NSString alloc] init];
    mstHumidity = [[NSString alloc] init];
    [self initData];
    [self initController];
    
    // Localization
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500; // meters
    
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyBest;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
}

- (void)initData {
    NSDictionary *jsonResponse = [Declarations getWeather:nUagLat and:nUagLng];
    [Parser parseWeather:jsonResponse];
    print(NSLog(@"mstTemp = %@", mstTemp))
    print(NSLog(@"mstTempMax = %@", mstTempMax))
    print(NSLog(@"mstTempMin = %@", mstTempMin))
    print(NSLog(@"mstPressure = %@", mstPressure))
    print(NSLog(@"mstHumidity = %@", mstHumidity))
}

- (void)initController {
}

- (IBAction)btnRefrsehPressed:(id)sender {
    
    NSLog(@"Get Location button pressed");
    
    //Location
    if (nil != self.locationManager){
        NSLog(@"Latitude: %lf, Longitude: %lf", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
        
        NSDictionary *jsonResponse = [Declarations getWeather:self.locationManager.location.coordinate.latitude and:self.locationManager.location.coordinate.longitude];
        [Parser parseWeather:jsonResponse];
        print(NSLog(@"mstTemp = %@", mstTemp))
        print(NSLog(@"mstTempMax = %@", mstTempMax))
        print(NSLog(@"mstTempMin = %@", mstTempMin))
        print(NSLog(@"mstPressure = %@", mstPressure))
        print(NSLog(@"mstHumidity = %@", mstHumidity))
    } else {
        NSLog(@"no locationManager is present!!!!");
        
        mstTemp = [[NSString alloc] init];
        mstTempMax = [[NSString alloc] init];
        mstTempMin = [[NSString alloc] init];
        mstPressure = [[NSString alloc] init];
        mstHumidity = [[NSString alloc] init];
    }

    self.lblTemp.text       = mstTemp;
    self.lblMax.text        = mstTempMax;
    self.lblMin.text        = mstTempMin;
    self.lblPressure.text   = mstPressure;
    self.lblHumidity.text   = mstHumidity;
}


/**********************************************************************************************/
#pragma mark - Localization
/**********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    NSLog(@"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            NSString *addressName = [placemark name];
            NSString *city = [placemark locality];
            NSString *administrativeArea = [placemark administrativeArea];
            NSString *country  = [placemark country];
            NSString *countryCode = [placemark ISOcountryCode];
            NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
        }
        
        //self.tfLatitude.text = [NSString stringWithFormat:@"%lf", self.locationManager.location.coordinate.longitude];
        //self.tfLongitude.text = [NSString stringWithFormat:@"%lf", self.locationManager.location.coordinate.longitude];
        
        
        //mlatitude = self.locationManager.location.coordinate.latitude;
        //mlongitude = self.locationManager.location.coordinate.longitude;
        NSLog(@"mlatitude = %f", self.locationManager.location.coordinate.latitude);
        NSLog(@"mlongitude = %f", self.locationManager.location.coordinate.longitude);
    }];
    
}


@end
