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
@synthesize bgImageView;
@synthesize messageView;
@synthesize messageTextView;
@synthesize messageButton;

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

-(void)show404Error{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"404 Unicorn Not Found" message:@"Check you're connected to the Internets and try again later.\nHe's always on the move." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [self disableView:YES];
}

-(void) fetchVenues{
    NSURL *venuesUrl = [NSURL URLWithString:@"http://10.0.1.198:3000/api.json"];
//    NSURL *venuesUrl = [NSURL URLWithString:@"http://sxswunicorn.herokuapp.com/api.json"];
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    [self disableView:NO];
    [self.searchingText setHidden:NO];
    [self.refreshButton setHidden:YES];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *resData = [NSData dataWithContentsOfURL:venuesUrl];
        app.networkActivityIndicatorVisible = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (resData != nil){
                NSError *jsonParsingError = nil;
                NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:resData options:0 error:&jsonParsingError];
                NSDictionary *messageDict = [resDict objectForKey:@"message"];
                if (messageDict != nil){
                    [self showMessage:[messageDict objectForKey:@"text"] withID:[[messageDict objectForKey:@"id"] integerValue] buttonText:[messageDict objectForKey:@"button_text"] buttonHidden:[[messageDict objectForKey:@"button_hidden"] boolValue]];
                }
                NSArray* latestVenues = [resDict objectForKey:@"venues"];
                if(latestVenues == nil || (NSNull *)latestVenues == [NSNull null]){
                    if(messageDict == nil)
                        [self show404Error];
                } else{
                    self.venues = [[NSMutableArray alloc] init];            
                    [latestVenues enumerateObjectsUsingBlock:^(NSDictionary *venueDict, NSUInteger idx, BOOL *stop) {
                        Venue *venue = [Venue initWithDictionary:venueDict];
                        [self.venues addObject:venue];
                    }];
                    [self configureView];
                }
            } else {
                [self show404Error];
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
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    swipe.direction = UISwipeGestureRecognizerDirectionUp;
//    [currentVenueButton addGestureRecognizer:swipe];
//    for (int idx = 0; idx < 4; idx++) {
//        [[self.otherVenueButtons objectAtIndex:idx] addGestureRecognizer:swipe
//         ];
//    }

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
    [self setMessageView:nil];
    [self setMessageTextView:nil];
    [self setMessageButton:nil];
    [self setBgImageView:nil];
    [super viewDidUnload];
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)recognizer{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No scrolling" message:@"Funny scrolling message!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
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

-(void) showMessage:(NSString *)message withID:(NSInteger)messageID buttonText:(NSString *) buttonText buttonHidden:(BOOL)buttonHidden{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger lastViewedMessageID = [defaults integerForKey:@"messageID"];
    if (messageID > lastViewedMessageID){
        [self.messageTextView setText:message];
        if (buttonText == (id)[NSNull null] || buttonText.length == 0 ) buttonText = @"OK";
        [self.messageButton setTitle:buttonText forState:UIControlStateNormal];
        [self.messageButton setHidden:buttonHidden];
        [self.messageButton setTag:messageID];
        [self.bgImageView setImage:[UIImage imageNamed:@"ViewControllerBGMessage.png"]];
        if(messageView.hidden || messageView.frame.size.height == 0.0f){
            [messageView setHidden:NO];
        }
    }
}

- (IBAction)refreshVenues:(id)sender {
    [self fetchVenues];
}

- (IBAction)didPressMessageButton:(id)sender {    
    [self.bgImageView setImage:[UIImage imageNamed:@"ViewControllerBG.png"]];
    [messageView setHidden:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[sender tag] forKey:@"messageID"];
    [defaults synchronize];
}

@end
