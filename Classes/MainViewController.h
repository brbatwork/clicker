//
//  MainViewController.h
//  iClicker
//
//  Created by Bill Barbour on 3/7/10.
//  Copyright Sogra Software LLC 2010. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Sounds.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	IBOutlet UIButton *up;
	IBOutlet UIButton *down;
	IBOutlet UIButton *reset;
	IBOutlet UILabel *theValue;
	int counter;
	int resetValue;
	int resetPresses;
	Sounds *upClick;
	Sounds *downClick;
}

- (IBAction) showInfo;
- (IBAction) increment;
- (IBAction) decrement;
- (IBAction) resetCounter: (id) sender;
- (IBAction) showResetHint: (id) sender;

@property(retain, nonatomic) IBOutlet UIButton *up;
@property(retain, nonatomic) IBOutlet UIButton *down;
@property(retain, nonatomic) IBOutlet UIButton *reset;
@property(retain, nonatomic) IBOutlet UILabel *theValue;

@end
