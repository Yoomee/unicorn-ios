//
//  VenueViewController.m
//  Chase the Unicorn
//
//  Created by Matthew Atkins on 02/02/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import "VenueViewController.h"
#import "Venue.h"

@implementation VenueViewController
@synthesize venueNameLabel;
@synthesize venueAddressLabel;
@synthesize venue = _venue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setVenueNameLabel:nil];
    [self setVenueAddressLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (IBAction)hideVenueView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)configureView{
    if (self.venue != nil) {
        [self.venueAddressLabel setText:self.venue.address];
        [self.venueNameLabel setText:self.venue.name];

    }
}

- (void)setVenue:(Venue *)newVenue {
	if (_venue != newVenue) {
		_venue = newVenue;
        // Update the view.
        [self configureView];
	}    
}
- (IBAction)didPressShowInMapsButton:(id)sender {
    [[UIApplication sharedApplication] openURL:self.venue.mapsURL];
}

- (IBAction)didPressShowInFoursquare:(id)sender {
    [[UIApplication sharedApplication] openURL:self.venue.foursquareURL];
}
@end
