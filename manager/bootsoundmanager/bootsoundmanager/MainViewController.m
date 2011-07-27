//
//  MainViewController.m
//  bootsoundmanager
//
//  Created by Vladislav on 27.07.11.
//  Copyright 2011 Tigr@Soft. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    system("rm -rf /var/mobile/Library/StartupSounds/.inuse.wav");
    [tableVw reloadData];
}

- (IBAction)about:(id)sender {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *ver;
    if ([fm fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/StartupSound.dylib"]) {
        if ([fm fileExistsAtPath:@"/var/mobile/.msg20"]) {
            ver = @"Found iStartupSound version 2.0, compatible.";
        } else if([fm fileExistsAtPath:@"/var/mobile/.donate"]) {
            ver = @"Found iStartupSound version 1.0.1, incompatible";
        } else {
            ver = @"Found iStartupSound, compatibility unknown";
        }
    } else {
        ver = @"iStartupSound not found";
    }
    
    UIAlertView *info = [[UIAlertView alloc]initWithTitle:@"iStartupSound Manager v1.1" message:[NSString stringWithFormat:@"For iStartupSound 2.0 and higher.\n%@\n\n © Vladislav Korotnev, 2011\nWebsite:\nhttp://vladkorotnev.github.com\n\nTwitter: @vladkorotnev",ver] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [info show];
    [info release];
    [ver release];
    [fm release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return YES;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

//---------------------------------
// Table
//---------------------------------

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *sets = [fm contentsOfDirectoryAtPath:@"/var/mobile/Library/StartupSounds" error:nil];
    // Return the number of rows in the section.
    return ([sets count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSFileManager *fm = [NSFileManager defaultManager];

    NSArray *sets = [fm contentsOfDirectoryAtPath:@"/var/mobile/Library/StartupSounds" error:nil];
    if ([fm fileExistsAtPath:@"/var/mobile/Library/StartupSounds/.inuse.wav"] && indexPath.row == 0) {
        [cell.textLabel setText:@"Disable"];
    } else {
        [cell.textLabel setText:[sets objectAtIndex:(indexPath.row)]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
             NSFileManager *fm = [NSFileManager defaultManager];
    NSLog(@"%d",indexPath.row);
    if ([[[[tableVw cellForRowAtIndexPath:indexPath]textLabel]text]isEqualToString:@"Disable"]) {
        [self showInfo:self];
        NSLog(@"rming");
        if (![fm fileExistsAtPath:@"/var/mobile/Library/StartupSounds/.inuse.wav"]) {
            UIAlertView *success = [[UIAlertView alloc]initWithTitle:@"Success" message:[NSString stringWithFormat:@"Successfully uninstalled sound",[tableVw cellForRowAtIndexPath:indexPath].textLabel.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [success show];
            [success release];
            [tableVw deselectRowAtIndexPath:indexPath animated:true];
        }
    } else {

        NSString *src = [NSString stringWithFormat:@"/var/mobile/Library/StartupSounds/%@",[tableVw cellForRowAtIndexPath:indexPath].textLabel.text];
        NSLog(@"installing");
        [self showInfo:self];
        [fm copyItemAtPath:src toPath:@"/var/mobile/Library/StartupSounds/.inuse.wav" error:nil];
        if ([fm fileExistsAtPath:@"/var/mobile/Library/StartupSounds/.inuse.wav"]) {
            UIAlertView *success = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully installed sound" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [success show];
            [success release];
            [tableVw deselectRowAtIndexPath:indexPath animated:true];
        }
    }
    [tableVw reloadData];
}


@end
