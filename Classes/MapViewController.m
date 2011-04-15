//
//  MapViewController.m
//  LuckyNumbers
//
//  Created by daihua ye on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

@synthesize lat, lon, location, placemark, businessName;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	mapView.mapType = MKMapTypeStandard;
	
	CLLocationDegrees l = [lat doubleValue];
	CLLocationDegrees o = [lon doubleValue];
	
	location = [[CLLocation alloc] initWithLatitude:l longitude:o];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void) viewWillAppear:(BOOL)animated
{
	coordinate = [self.location coordinate];
//	NSString *locationOfPoint = [[NSString alloc] initWithFormat:@"%@, %@", lat, lon];
	NSDictionary *address = [NSDictionary dictionaryWithObjectsAndKeys:self.businessName, @"Country", nil];
	placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:address];
	[mapView addAnnotation:placemark];

	[self goToLocation];
	address = nil;
}

-(void) viewWillDisappear:(BOOL)animated
{
	[mapView removeAnnotation:placemark];
}

- (void)goToLocation
{
	MKCoordinateRegion newRegion;
    newRegion.center.latitude = coordinate.latitude;
    newRegion.center.longitude = coordinate.longitude;
    newRegion.span.latitudeDelta = 0.01;
    newRegion.span.longitudeDelta = 0.01;
	
    [mapView setRegion:newRegion animated:YES];	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
	NSLog(@"Memory Leak in MapViewController");
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.placemark = nil;
	self.location = nil;
	self.businessName = nil;
	self.lat = nil;
	self.lon = nil;
}


- (void)dealloc {
	[lat release];
	[lon release];
	[mapView release];
	[placemark release];
	[location release];
	[businessName release];
    [super dealloc];
}


@end
