//  AsyncServices.h
//
//  Copyright (C) 2013 BromanceApp

#import <Foundation/Foundation.h>

#define GEO_LOCATION_UPDATED @"GeoLocationUpdated"
#define LAT_LNG_UPDATED @"LatLngUpdated"

@interface AsyncServices : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) NSString *geoLocation;
@property (strong, nonatomic) CLLocation *lastLocation;

+ (AsyncServices *)instance;
- (void)saveInitialUserData;
- (void)initLocationManager;

@end
