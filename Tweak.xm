#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)x {
    %orig;
	//startup sound
    NSFileManager *fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:@"/var/mobile/startup.wav"]){
        NSURL *newURL = [[NSURL alloc] initFileURLWithPath:@"/var/mobile/startup.wav"];
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:newURL error:nil];
        [player prepareToPlay];
        [player play];
        [newURL release];
    }
    [fm release];
}
    
%end
