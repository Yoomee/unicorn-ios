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
}

- (void)viewDidUnload
{
    [self setImageView:nil];
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
