//
//  ViewController.m
//  Chasing the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize venues;
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

#pragma mark - Venue methods
- (Venue *)currentVenue
{
    if ([venues count] > 0) {
        return [venues objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSArray *)otherVenueNameLabels
{
    return [[NSArray alloc] initWithObjects:otherVenue1NameLabel, otherVenue2NameLabel,otherVenue3NameLabel, otherVenue4NameLabel, nil];
}

-(void)updateVenueLabels{
    [currentVenueNameLabel setText:self.currentVenue.name];
    for (int idx = 0; idx < 4; idx++) {
        [[self.otherVenueNameLabels objectAtIndex:idx] setText:[[self.venues objectAtIndex:(idx + 1)] name]];
    }
}


#pragma mark - Data

-(void) fetchVenues{
    NSURL *venuesUrl = [NSURL URLWithString:@"http://dl.dropbox.com/u/1641228/unicorn/venues.json"];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *venuesData = [NSData dataWithContentsOfURL:venuesUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSError *jsonParsingError = nil;
			NSDictionary *venuesDictionary = [NSJSONSerialization JSONObjectWithData:venuesData options:0 error:&jsonParsingError];
            
            NSArray* latestVenues = [venuesDictionary objectForKey:@"venues"];
            self.venues = [[NSMutableArray alloc] init];            
            
            [latestVenues enumerateObjectsUsingBlock:^(NSDictionary *venueDict, NSUInteger idx, BOOL *stop) {
                Venue *venue = [Venue initWithDictionary:venueDict];
                [self.venues addObject:venue];
            }];
            [self updateVenueLabels];

        });        
    });   
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{   
    [self fetchVenues];
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
