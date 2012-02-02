//
//  VenueViewController.h
//  Chase the Unicorn
//
//  Created by Matthew Atkins on 02/02/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Venue;

@interface VenueViewController : UIViewController
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *venueAddressLabel;
@property (strong, nonatomic) Venue *venue;
- (IBAction)hideVenueView:(id)sender;
-(void)configureView;
@end
