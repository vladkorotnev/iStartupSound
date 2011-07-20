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
    if([fm fileExistsAtPath:@"/System/Library/CoreServices/SpringBoard.app/startup.wav"]){
        NSURL *newURL = [[NSURL alloc] initFileURLWithPath:@"/var/mobile/startup.wav"];
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:newURL error:nil];
        [player prepareToPlay];
        [player setDelegate:ololo];
        [player play];
        [newURL release];
    }
    [fm release];
    
    //please :)
    
    if(![fm fileExistsAtPath:@"/var/mobile/.donate"]){
    	system("touch /var/mobile/.donate");
    	Class _SBAwayController = NSClassFromString(@"SBAwayController");
[[_SBAwayController sharedAwayController]unlockWithSound:true isAutoUnlock:true];
    	UIAlertView *hello = [[UIAlertView alloc]initWithTitle:@"iStartupSound" message:@"Hello. \n Thanks for using iStartupSound. \n Warning: Since now startup.wav has moved to /System/Library/CoreServices/SpringBoard.app/startup.wav. \n Please move your files. \n Also, the new location for the file would allow use of startup sounds in themes. \n Thank you for using iStartupSound. \n Would you please donate me as little as $1 (you may donate more if you wish :) to keep the good software development?\n If you would like to donate, go to: \n http://vladkorotnev.github.com/donate \n\n \n P.S. A new, better successor to iStartupSound is coming. Stay tuned on twitter: \n @vladkorotnev" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    	[hello show];
    	[hello release];
    }
}
    
%end
