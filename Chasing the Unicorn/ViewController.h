//
//  ViewController.h
//  Chasing the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Venue.h"
#import "VenueViewController.h"

@interface ViewController : UIViewController
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *currentVenueButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *otherVenue1Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *otherVenue2Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *otherVenue3Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *otherVenue4Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *refreshButton;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *searchingText;
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *bgImageView;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *messageView;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *messageTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *messageButton;

@property (nonatomic, strong) NSMutableArray *venues;
@property (strong, nonatomic) VenueViewController *venueViewController;

-(void)showMessage:(NSString *)message withID:(NSInteger)messageID buttonText:(NSString *)buttonText buttonHidden:(BOOL)buttonHidden;

- (IBAction)showAbout:(id)sender;
- (IBAction)showVenue:(id)sender;
- (IBAction)refreshVenues:(id)sender;
- (IBAction)didPressMessageButton:(id)sender;

@end
