//
//  Event.m
//  iClicker
//
//  Created by Bill Barbour on 3/18/10.
//  Copyright 2010 Sogra Software LLC. All rights reserved.
//

#import "Event.h"


@implementation Event
@synthesize description;
@synthesize counter;

- (void)dealloc {
	[description release];
	[counter release];
    [super dealloc];
}
@end
