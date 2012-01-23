//
//  ViewController.h
//  Chasing the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Venue.h"

@interface ViewController : UIViewController
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *currentVenueNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *otherVenue1NameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *otherVenue2NameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *otherVenue3NameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *otherVenue4NameLabel;
@property (nonatomic, strong) NSMutableArray *venues;

@end
