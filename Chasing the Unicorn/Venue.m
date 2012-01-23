//
//  Venue.m
//  Chasing the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import "Venue.h"

@implementation Venue

@synthesize fsId,name,address,city,state,country,lat,lng,hereNow; 

+(Venue *) initWithDictionary:(NSDictionary *)dictionary
{
    Venue *newVenue = [[Venue alloc] init];
    newVenue.fsId = [dictionary objectForKey:@"id"];
    newVenue.name = [dictionary objectForKey:@"name"];
    NSDictionary *locationDict = [dictionary objectForKey:@"location"];
    newVenue.address = [locationDict objectForKey:@"address"];
    newVenue.city = [locationDict objectForKey:@"city"];
    newVenue.state = [locationDict objectForKey:@"state"];
    newVenue.country = [locationDict objectForKey:@"country"];
    newVenue.lat = [[locationDict objectForKey:@"lat"] floatValue];
    newVenue.lng = [[locationDict objectForKey:@"lng"] floatValue];
    newVenue.hereNow = [[[dictionary objectForKey:@"hereNow"] objectForKey:@"count"] intValue];
    return newVenue;
}

@end
