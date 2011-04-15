//
//  TableViewController.m
//  LuckyNumbers
//
//  Created by daihua ye on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "LuckyNumbersAppDelegate.h"
#import "MapViewController.h"


@implementation TableViewController

@synthesize table;
@synthesize latitudes;
@synthesize longitudes;
@synthesize businessNames;
@synthesize businessAddresses;
@synthesize distance;

@synthesize childMapVC;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"%@", [latitudes objectAtIndex:0]);
}

#pragma mark -
#pragma mark Table view methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [businessNames count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * const CellIdentifier = @"CellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.textLabel.text = [businessNames objectAtIndex:indexPath.row];
//	NSLog(@"distance %@", [distance objectAtIndex:indexPath.row]);
//	NSString dis = ;
	
	NSNumber *number = [distance objectAtIndex:indexPath.row];
	
	NSLog(@"%@", number);
	
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f meters", [number floatValue]];
	
	
	return cell;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50; // Default height for the cell is 44 px;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	LuckyNumbersAppDelegate *delegate = (LuckyNumbersAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	MapViewController *mapVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
	
//	CLLocationCoordinate2D coordinate = {
//		[latitudes objectAtIndex:indexPath.row], [longitudes objectAtIndex:indexPath.row]
//	}
//	double lat = [NSNumber numberWithDouble:[latitudes objectAtIndex:indexPath.row]];
//	double lon = [NSNumber numberWithDouble:[longitudes objectAtIndex:indexPath.row]];
//	NSLog(@"String: %@", [latitudes objectAtIndex:indexPath.row]);
//	double lat = [[latitudes objectAtIndex:indexPath.row] doubleValue];
//	NSLog(@"%f", lat);
	
	
//	CLLocationDegrees lon = [[longitudes objectAtIndex:indexPath.row] doubleValue];
//	location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
//	NSLog(@"location: %@", location.coordinate.latitude);
//	mapVC.location = location;
		
	mapVC.lat = [latitudes objectAtIndex:indexPath.row];
	mapVC.lon = [longitudes objectAtIndex:indexPath.row];
	mapVC.businessName = [businessNames objectAtIndex:indexPath.row];
	self.childMapVC = mapVC;
	
	[delegate.navigationController pushViewController:childMapVC animated:YES];
	[mapVC release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Memory Managment

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	NSLog(@"Memory Warning for TableViewController");
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.table = nil;
	self.latitudes = nil;
	self.longitudes = nil;
	self.businessNames = nil;
	self.businessAddresses = nil;
	self.childMapVC = nil;
	self.distance = nil;
}


- (void)dealloc {
	[table release];
	[latitudes release];
	[longitudes release];
	[businessNames release];
	[businessAddresses release];
	[childMapVC release];
	[location release];
	[distance release];
    [super dealloc];
}


@end
