//
//  MapViewController.h
//  LuckyNumbers
//
//  Created by daihua ye on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate> {
	IBOutlet MKMapView *mapView;
	CLLocation *location;
	MKPlacemark *placemark;
	CLLocationCoordinate2D coordinate;
	NSString *lat;
	NSString *lon;
	NSString *businessName;
}

@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) MKPlacemark *placemark;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lon;
@property (nonatomic, retain) NSString *businessName;

- (void)goToLocation;

@end
