//
//  iClickerAppDelegate.h
//  iClicker
//
//  Created by Bill Barbour on 3/7/10.
//  Copyright Sogra Software LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface iClickerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end

