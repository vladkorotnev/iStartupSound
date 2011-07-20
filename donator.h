#import <objc/runtime.h>

@interface Donator : NSObject <UIAlertViewDelegate> {

}

-(void)MyAlertViewIs:(UIAlertView *)alert;

@property (nonatomic,retain) UIAlertView *myAlert;
@end