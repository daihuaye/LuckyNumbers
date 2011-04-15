//
//  TableViewController.h
//  LuckyNumbers
//
//  Created by daihua ye on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class MapViewController;

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *table;
	
	NSMutableArray *latitudes;
	NSMutableArray *longitudes;
	NSMutableArray *businessNames;
	NSMutableArray *businessAddresses;	
	NSMutableArray *distance;
	
	MapViewController *childMapVC;
	
	CLLocation *location;
}

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *latitudes;
@property (nonatomic, retain) NSMutableArray *longitudes;
@property (nonatomic, retain) NSMutableArray *businessNames;
@property (nonatomic, retain) NSMutableArray *businessAddresses;
@property (nonatomic, retain) NSMutableArray *distance;

@property (nonatomic, retain) MapViewController *childMapVC;

@end
