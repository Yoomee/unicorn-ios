//
//  SplashScreenController.m
//  Chase the Unicorn
//
//  Created by Matthew Atkins on 02/02/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import "SplashScreenController.h"

@implementation SplashScreenController
@synthesize imageView;
@synthesize phrases;
@synthesize phraseLabel;

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

- (void) changePhrase{
    NSInteger nextPhraseIndex = (self.phraseLabel.tag + 1) % [self.phrases count];
    [self.phraseLabel setText:[self.phrases objectAtIndex:nextPhraseIndex]];
    [self.phraseLabel setTag:nextPhraseIndex];
    if (self.isViewLoaded && self.view.window)
        [self performSelector:@selector(changePhrase) withObject:nil afterDelay:3.0f];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"Loading1.png"],
                             [UIImage imageNamed:@"Loading2.png"],
                             [UIImage imageNamed:@"Loading3.png"],
                             [UIImage imageNamed:@"Loading4.png"],
                             nil];
	imageView.animationImages = imageArray;
	imageView.animationDuration = 0.8;
    imageView.contentMode = UIViewContentModeBottom;
	[imageView startAnimating];
    
    NSArray *myPhrases = [[NSArray alloc] initWithObjects:
                          @"Locating the unicorn...",
                          @"Awaking unicorn from slumber...",
                          @"Gathering magical fairies...",
                          @"Repelling evil trolls...",
                          @"A double rainbow! Whoa! What does it mean?",
                          @"You should never play leapfrog with a unicorn.",
                          @"Weather forecast for tonight: dark.",
                          @"Will the unicorn be willing to serve thee?",
                          @"My hovercraft is full of eels.",
                          @"I said no to drugs, but they didn’t listen.",
                          @"I intend to live forever. So far, so good.",
                          nil];
    self.phrases = myPhrases;
    [self performSelector:@selector(changePhrase) withObject:nil afterDelay:3.0f];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setPhraseLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
