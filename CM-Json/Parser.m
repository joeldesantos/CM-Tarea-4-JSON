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
        NSDictionary    *weather = [json valueForKey: @"weather"];

        //[°C] = ([°F] - 32) × 5/9
        //double tempC = (tempK -32) * (5 / 9);
        //NSString *strTempCelcius = [NSString stringWithFormat:@"%.2f ˚C", tempC];
        
        NSString *tmp = [NSString stringWithFormat:@"%@", [weather valueForKey:@"icon"]];
        NSString *tmp2 = [tmp substringWithRange:NSMakeRange([tmp rangeOfString:@"("].location+6, 3)];
        mstIcon     = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", tmp2];//[weather valueForKey:@"icon"]];
        mstTemp     = [self getCelciusFromKelvin:[[main valueForKey: @"temp"]doubleValue]];
        mstTempMax  = [self getCelciusFromKelvin:[[main valueForKey: @"temp_max"]doubleValue]];
        mstTempMin  = [self getCelciusFromKelvin:[[main valueForKey: @"temp_min"]doubleValue]];
        mstHumidity = [NSString stringWithFormat:@"%@ %@", [[main valueForKey: @"humidity"]stringValue], @"%"];
        mstPressure = [NSString stringWithFormat:@"%@ atm", [[main valueForKey: @"pressure"]stringValue]];
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
