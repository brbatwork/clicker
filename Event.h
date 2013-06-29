//
//  Event.h
//  iClicker
//
//  Created by Bill Barbour on 3/18/10.
//  Copyright 2010 Sogra Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Event : NSObject {
	NSString *description;
	NSString *counter;
}

@property (retain, nonatomic) NSString *description;
@property (retain, nonatomic) NSString *counter;

@end
