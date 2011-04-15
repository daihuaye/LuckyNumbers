//
//  LuckyNumbersViewController.m
//  LuckyNumbers
//
//  Created by daihua ye on 10/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LuckyNumbersViewController.h"
#import "JSON.h"
#import "LuckyNumbersAppDelegate.h"
#import "TableViewController.h"
#import "ASIHTTPRequest.h"

@implementation LuckyNumbersViewController

@synthesize childTableVC, locationManager;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[self locationManager] startUpdatingLocation];
}


-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[responseData setLength:0];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[responseData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	label.text = [NSString stringWithFormat:@"Connection fail: %@", [error description]];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	[connection release];
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
	
	NSDictionary *luckyNumbers = [responseString JSONValue];

	[responseString release];
	
	businesses = [luckyNumbers valueForKey:@"businesses"];
	latitudes = [[NSMutableArray alloc] initWithCapacity:[businesses count]];
	longitudes = [[NSMutableArray alloc] initWithCapacity:[businesses count]];
	businessNames= [[NSMutableArray alloc] initWithCapacity:[businesses count]];
	businessAddresses = [[NSMutableArray alloc] initWithCapacity:[businesses count]];
	

	for (int i = 0; i < [businesses count]; i++) {
		[latitudes insertObject:[(NSDictionary *)[businesses objectAtIndex:i] objectForKey:@"lat"] atIndex:i];
		[longitudes insertObject:[(NSDictionary *)[businesses objectAtIndex:i] objectForKey:@"lon"] atIndex:i];
		[businessNames insertObject:[(NSDictionary *)[businesses objectAtIndex:i] objectForKey:@"name"] atIndex:i];
		[businessAddresses insertObject:[(NSDictionary *)[businesses objectAtIndex:i] objectForKey:@"address"] atIndex:i];
		[distance insertObject:[(NSDictionary *)[businesses objectAtIndex:i] objectForKey:@"distance"] atIndex:i];
	}

	NSMutableString *text = [NSMutableString stringWithString:@""];
	for (int i = 0; i < [businesses count]; i++) {
		[text appendFormat:@"%@\n", [businessNames objectAtIndex:i]];
		[text appendFormat:@"%@\n", [businessAddresses objectAtIndex:i]];
		[text appendFormat:@"%@, %@\n", [latitudes objectAtIndex:i], [longitudes objectAtIndex:i]];
		[text appendFormat:@"\n"];		
	}
	label.text = @"Business Information:";
//	textView.text = text;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark ASIHTTPRequest
-(IBAction)grabURL:(id)sender
{
	CLLocation *location = [locationManager location];
	
	if (!location) {
		return;
	}
	
	NSURL *url = [NSURL URLWithString:@"http://test-data-app.googlecode.com/svn/trunk/test.json"];
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Error: %@", error);
}

#pragma mark -
#pragma mark text input
- (void)awakeFromNib
{
	NSLog(@"awaken");
	[domainURL setDelegate:self];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"sup");
	[textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	
	NSArray *bs = [responseString JSONValue];
	
	NSLog(@"%d", [bs count] );
	if ([bs count] == 0) {
		
	}
		
	latitudes = [[NSMutableArray alloc] initWithCapacity:[bs count]];
	longitudes = [[NSMutableArray alloc] initWithCapacity:[bs count]];
	businessNames= [[NSMutableArray alloc] initWithCapacity:[bs count]];
	distance = [[NSMutableArray alloc] initWithCapacity:[bs count]];
	
	for (int i = 0; i < [bs count]; i++) {
		[latitudes insertObject:[[[bs objectAtIndex:i] objectForKey:@"business"] objectForKey:@"lat"] atIndex:i];
		[longitudes insertObject:[[[bs objectAtIndex:i] objectForKey:@"business"] objectForKey:@"lon"] atIndex:i];
		[businessNames insertObject:[[[bs objectAtIndex:i] objectForKey:@"business"] objectForKey:@"name"] atIndex:i];
		[businessAddresses insertObject:[[[bs objectAtIndex:i] objectForKey:@"business"] objectForKey:@"street_1"] atIndex:i];
		[distance insertObject:[[[bs objectAtIndex:i] objectForKey:@"business"] objectForKey:@"distance"] atIndex:i];
	}

	[self locateMe];
}

#pragma mark -
#pragma mark CLLocation mothods
-(CLLocationManager *) locationManager
{
	if (locationManager != nil) {
		return locationManager;
	}
	
	locationManager = [[CLLocationManager alloc] init];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
	[locationManager setDelegate:self];
	
	return locationManager;
}


#pragma mark -
#pragma mark View Action
-(IBAction)locateMe
{
//	CLLocation *location = [locationManager location];
//	
//	if (!location) {
//		return;
//	}
//	
//	CLLocationCoordinate2D coordinate = [location coordinate];
	
	
	
//	NSLog(@"latitude: %@\n", [NSNumber numberWithDouble:coordinate.latitude]);
//	NSLog(@"Longitude: %@\n", [NSNumber numberWithDouble:coordinate.longitude]);	
	
	LuckyNumbersAppDelegate *delegate = (LuckyNumbersAppDelegate *)[[UIApplication sharedApplication] delegate];
	TableViewController *tableVC = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
	tableVC.latitudes = latitudes;
	tableVC.longitudes = longitudes;
	tableVC.businessNames = businessNames;
	tableVC.businessAddresses = businessAddresses;
	tableVC.distance = distance;

	tableVC.title = @"Table Demo";
	self.childTableVC = tableVC;
	[delegate.navigationController pushViewController:childTableVC animated:YES];
	
	[tableVC release];
}

#pragma mark -
#pragma mark Memory Mamangment

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	NSLog(@"Memory Warning From LuckyNumberViewController");
}

- (void)viewDidUnload {
	self.locationManager = nil;
	self.childTableVC = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[latitudes release];
	[longitudes release];
	[businessNames release];
	[businessAddresses release];
	[childTableVC release];
	[locationManager release];
	[distance release];
    [super dealloc];
}

@end
