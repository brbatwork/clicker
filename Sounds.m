//
//  Sounds.m
//  iClicker
//
//  Created by Bill Barbour on 3/26/10.
//  Copyright 2010 Sogra Software LLC. All rights reserved.
//

#import "Sounds.h"


@implementation Sounds

-(id) initWithContentsOfFile:(NSString *)path {
	self = [super init];
	
	if (self != nil) {
		NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
		AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
	}
	return self;
}

-(void) play {
	AudioServicesPlaySystemSound(soundID);
}

-(void) dealloc {
	AudioServicesDisposeSystemSoundID(soundID);
	[super dealloc];
}

@end
