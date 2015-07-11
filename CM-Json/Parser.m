//
//  Parser.m
//  CM-Json
//
//  Created by Walter Gonzalez Domenzain on 11/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Parser.h"

@implementation Parser

+ (void)parseWeather:(NSDictionary*)json {
    //check for valid value
    if(json != nil){
        NSDictionary    *main = [json valueForKey: @"main"];

        //[°C] = ([°F] - 32) × 5/9
        //double tempC = (tempK -32) * (5 / 9);
        //NSString *strTempCelcius = [NSString stringWithFormat:@"%.2f ˚C", tempC];
        
        
        mstTemp     = [self getCelciusFromKelvin:[[main valueForKey: @"temp"]doubleValue]];
        mstHumidity = [NSString stringWithFormat:@"%@ %@", [[main valueForKey: @"humidity"]stringValue], @"%"];
        mstPressure = [NSString stringWithFormat:@"%@ %@", [[main valueForKey: @"pressure"]stringValue], @"atm"];
        mstTempMax  = [self getCelciusFromKelvin:[[main valueForKey: @"temp_max"]doubleValue]];
        mstTempMin  = [self getCelciusFromKelvin:[[main valueForKey: @"temp_min"]doubleValue]];
    }
}

+ (NSString *) getCelciusFromKelvin:(double)tempK {
    //ºC =K - 273.15
    double tempC = tempK - 273.15;
    NSString *strTempCelcius = [NSString stringWithFormat:@"%.2f ˚C", tempC];
    return strTempCelcius;
}

+ (NSString *) getFarenheitFromKelvin:(double)tempK {
    //ºF =(K - 273.15)* 1.8000 + 32.00
    double tempF = ((tempK - 273.15) * 1.8000) + 32.00;
    NSString *strTempCelcius = [NSString stringWithFormat:@"%.2f ˚F", tempF];
    return strTempCelcius;
}


@end
