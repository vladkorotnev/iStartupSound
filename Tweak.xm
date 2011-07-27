#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "SndDelegate.h"

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)x {
    %orig;
	//startup sound
    NSFileManager *fm=[NSFileManager defaultManager];
    SndDelegate *ololo = [SndDelegate alloc];
    if([fm fileExistsAtPath:@"/var/mobile/Library/StartupSounds/.inuse.wav"]){
        NSURL *newURL = [[NSURL alloc] initFileURLWithPath:@"/var/mobile/Library/StartupSounds/.inuse.wav"];
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:newURL error:nil];
        [player prepareToPlay];
        [player setDelegate:ololo];
        [player play];
        [newURL release];
    }
    [fm release];
    
    //please :)
    
    if(![fm fileExistsAtPath:@"/var/mobile/.msg20"]){
    	system("touch /var/mobile/.msg20");
    	system("rm /var/mobile/.donate");
    	Class _SBAwayController = NSClassFromString(@"SBAwayController");
[[_SBAwayController sharedAwayController]unlockWithSound:true isAutoUnlock:true];
    	UIAlertView *hello = [[UIAlertView alloc]initWithTitle:@"iStartupSound 2.0" message:@"Hello.\nThanks for using iStartupSound.\nWarning: Since now, iStartupSound has a sound manager. Place your files into /var/mobile/Library/StartupSounds with any name.\nThank you for using iStartupSound. \n Would you please donate me as little as $1 (you may donate more if you wish :) to keep the good software development?\nIf you would like to donate, go to:\nhttp://vladkorotnev.github.com/donate" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    	[hello show];
    	[hello release];
    }
}
    
%end
