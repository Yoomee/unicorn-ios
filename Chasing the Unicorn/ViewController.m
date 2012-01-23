//
//  ViewController.m
//  Chasing the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize currentVenueNameLabel;
@synthesize otherVenue1NameLabel;
@synthesize otherVenue2NameLabel;
@synthesize otherVenue3NameLabel;
@synthesize otherVenue4NameLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [currentVenueNameLabel setText:@"Ian's house"];
    [otherVenue1NameLabel setText:@"Matt's house"];
    [otherVenue2NameLabel setText:@"Si's house"];
    [otherVenue3NameLabel setText:@"Rich's house"];
    [otherVenue4NameLabel setText:@"Andy's house"];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCurrentVenueNameLabel:nil];
    [self setOtherVenue1NameLabel:nil];
    [self setOtherVenue2NameLabel:nil];
    [self setOtherVenue3NameLabel:nil];
    [self setOtherVenue4NameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
