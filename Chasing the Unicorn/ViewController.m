//
//  ViewController.m
//  Chasing the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import "SplashScreenController.h"
#import "VenueViewController.h"

@implementation ViewController

@synthesize venues;
@synthesize currentVenueButton;
@synthesize otherVenue1Button;
@synthesize otherVenue2Button;
@synthesize otherVenue3Button;
@synthesize otherVenue4Button;
@synthesize refreshButton;
@synthesize searchingText;
@synthesize activityIndicator;

@synthesize venueViewController = _venueViewController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Venue methods
- (Venue *)currentVenue
{
    if ([venues count] > 0) {
        return [venues objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSArray *)otherVenueButtons
{
    return [[NSArray alloc] initWithObjects:otherVenue1Button, otherVenue2Button,otherVenue3Button, otherVenue4Button, nil];
}

-(void)configureView{
    [currentVenueButton setTitle:self.currentVenue.name forState:UIControlStateNormal];
    [currentVenueButton setEnabled:YES];
    for (int idx = 0; idx < 4; idx++) {
        [[self.otherVenueButtons objectAtIndex:idx] setTitle:[[self.venues objectAtIndex:(idx + 1)] name] forState:UIControlStateNormal];
        [[self.otherVenueButtons objectAtIndex:idx] setEnabled:YES];
    }
}

-(void)disableView:(BOOL)clear{
    if (clear)
        [currentVenueButton setTitle:@"" forState:UIControlStateNormal];
    [currentVenueButton setEnabled:NO];
    for (int idx = 0; idx < 4; idx++) {
        if (clear)
            [[self.otherVenueButtons objectAtIndex:idx] setTitle:@"" forState:UIControlStateNormal];
        [[self.otherVenueButtons objectAtIndex:idx] setEnabled:NO];
    }
}


#pragma mark - Data

-(void) fetchVenues{
    NSURL *venuesUrl = [NSURL URLWithString:@"http://dl.dropbox.com/u/1641228/unicorn/venues.json"];
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    [self disableView:NO];
    [self.searchingText setHidden:NO];
    [self.refreshButton setHidden:YES];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *venuesData = [NSData dataWithContentsOfURL:venuesUrl];
        app.networkActivityIndicatorVisible = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (venuesData != nil){
                NSError *jsonParsingError = nil;
                NSDictionary *venuesDictionary = [NSJSONSerialization JSONObjectWithData:venuesData options:0 error:&jsonParsingError];
                
                NSArray* latestVenues = [venuesDictionary objectForKey:@"venues"];
                self.venues = [[NSMutableArray alloc] init];            
                
                [latestVenues enumerateObjectsUsingBlock:^(NSDictionary *venueDict, NSUInteger idx, BOOL *stop) {
                    Venue *venue = [Venue initWithDictionary:venueDict];
                    [self.venues addObject:venue];
                }];
                [self configureView];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"404 Unicorn Not Found" message:@"Check you're connected to the Internets and try again later.\nHe's always on the move." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [self disableView:YES];
            }
            [self.searchingText setHidden:YES];
            [self.activityIndicator stopAnimating];
            [self.activityIndicator setHidden:YES];
            [self.refreshButton setHidden:NO];
        });
        
    });   
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{ 
    [super viewDidLoad];
    [self disableView:YES];
}

- (void)viewDidUnload
{
    [self setCurrentVenueButton:nil];
    [self setOtherVenue1Button:nil];
    [self setOtherVenue2Button:nil];
    [self setOtherVenue3Button:nil];
    [self setOtherVenue4Button:nil];
    [self setVenueViewController:nil];
    [self setActivityIndicator:nil];
    [self setRefreshButton:nil];
    [self setSearchingText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchVenues];
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (IBAction)showAbout:(id)sender {
    AboutViewController *a = [[AboutViewController alloc] init];
	[a setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self presentModalViewController:a animated:YES];
}

- (IBAction)showVenue:(id)sender {
    if(_venueViewController == nil){
        VenueViewController *aVenueViewController = [[VenueViewController alloc] init];
        [aVenueViewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        _venueViewController = aVenueViewController;
    }
    
    [self.venueViewController setVenue:[self.venues objectAtIndex:[sender tag]]];
	[self presentModalViewController:self.venueViewController animated:YES];
}

- (IBAction)refreshVenues:(id)sender {
    [self fetchVenues];
}

@end
