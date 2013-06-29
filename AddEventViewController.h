//
//  AddEventViewController.h
//  iClicker
//
//  Created by Bill Barbour on 3/10/10.
//  Copyright 2010 Sogra Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddEventDelegate;

@interface AddEventViewController : UIViewController <UITextFieldDelegate> {
	id<AddEventDelegate> delegate;
	IBOutlet UITextField *eventDescription;
	UIBarButtonItem *cancelButton;
	UIBarButtonItem *saveButton;
	IBOutlet UILabel *theValue;
}

@property (nonatomic, assign) id <AddEventDelegate> delegate;
@property (nonatomic, assign) UITextField *eventDescription;
@property (nonatomic, retain) IBOutlet UILabel *theValue;

@end

@protocol AddEventDelegate
-(void) addEventViewControllerDidSave:(AddEventViewController *) controller withDescription: (NSString *) description;
-(void) addEventViewControllerDidCancel: (AddEventViewController *) controller;
-(NSInteger) retrieveCounter;
@end
