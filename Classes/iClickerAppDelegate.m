//
//  iClickerAppDelegate.m
//  iClicker
//
//  Created by Bill Barbour on 3/7/10.
//  Copyright Sogra Software LLC 2010. All rights reserved.
//

#import "iClickerAppDelegate.h"
#import "MainViewController.h"

@implementation iClickerAppDelegate


@synthesize window;
@synthesize mainViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void) applicationWillTerminate:(UIApplication *)application {
	NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
	int value = [[[mainViewController theValue] text] intValue];
	[userPreferences setInteger:value forKey:@"counterValue"];
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
