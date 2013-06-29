//
//  Sounds.h
//  iClicker
//
//  Created by Bill Barbour on 3/26/10.
//  Copyright 2010 Sogra Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>


@interface Sounds : NSObject {
	SystemSoundID soundID;
}

-(id) initWithContentsOfFile:(NSString *) path;
-(void) play;

@end
