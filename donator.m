#import "donator.h"

@implementation Donator
@synthesize myAlert;

-(void)MyAlertViewIs:(UIAlertView *)alert{
	myAlert = alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
if(alertView == myAlert && buttonIndex == 1) {
NSURL *url = [[NSURL alloc]initWithString: @"http://vladkorotnev.github.com/for_apps/donate/donate.html"];
[[UIApplication sharedApplication]openURL:url];
}
}
@end