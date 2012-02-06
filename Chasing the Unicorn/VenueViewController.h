//
//  VenueViewController.h
//  Chase the Unicorn
//
//  Created by Matthew Atkins on 02/02/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class Venue;

@interface VenueViewController : UIViewController
@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *mapView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *venueAddressLabel;
@property (strong, nonatomic) Venue *venue;

-(void)configureView;

- (IBAction)hideVenueView:(id)sender;
- (IBAction)didPressShowInMapsButton:(id)sender;
- (IBAction)didPressShowInFoursquare:(id)sender;
@end
