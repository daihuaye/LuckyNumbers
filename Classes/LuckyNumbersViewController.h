//
//  LuckyNumbersViewController.h
//  LuckyNumbers
//
//  Created by daihua ye on 10/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class TableViewController;

@interface LuckyNumbersViewController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate> {
	NSMutableData *responseData;
	
	IBOutlet UILabel *label;
//	IBOutlet UIButton *locateMeButton;
//	IBOutlet UITextView *textView;
	IBOutlet UITextField *domainURL;
	
	NSArray *businesses;
	NSMutableArray *latitudes;
	NSMutableArray *longitudes;
	NSMutableArray *businessNames;
	NSMutableArray *businessAddresses;
	NSMutableArray *distance;
	
	TableViewController *childTableVC;
	
	// locate yourself
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) TableViewController *childTableVC;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(IBAction)locateMe;
-(IBAction)grabURL:(id)sender;

@end

