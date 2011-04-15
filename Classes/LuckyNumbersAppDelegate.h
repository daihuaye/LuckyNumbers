//
//  LuckyNumbersAppDelegate.h
//  LuckyNumbers
//
//  Created by daihua ye on 10/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LuckyNumbersViewController;

@interface LuckyNumbersAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LuckyNumbersViewController *viewController;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LuckyNumbersViewController *viewController;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

