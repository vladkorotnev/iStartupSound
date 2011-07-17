#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import "SndDelegate.h"
%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)x {
    %orig;
	//startup sound
    NSFileManager *fm=[NSFileManager defaultManager];
    SndDelegate *ololo = [SndDelegate alloc];
    if([fm fileExistsAtPath:@"/var/mobile/startup.wav"]){
        NSURL *newURL = [[NSURL alloc] initFileURLWithPath:@"/var/mobile/startup.wav"];
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:newURL error:nil];
        [player prepareToPlay];
        [player setDelegate:ololo];
        [player play];
        [newURL release];
    }
    [fm release];
}
    
%end
