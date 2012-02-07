//
//  Venue.h
//  Chase the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject

@property (nonatomic, strong) NSString *fsId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property float lat;
@property float lng;
@property int hereNow;

+(Venue *) initWithDictionary: (NSDictionary *) dictionary;

-(NSString *) latLngString;
-(NSURL *) foursquareURL;
-(NSURL *) mapsURL;

@end
