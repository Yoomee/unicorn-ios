#import "MyCLController.h"

@implementation MyCLController

@synthesize locationManager;

- (id) init {
	self = [super init];
	if (self != nil) {
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self; // send loc updates to myself
	}
	return self;
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float lastLat = [defaults floatForKey:@"lat"];
    float lastLng = [defaults floatForKey:@"lat"];
    if ((lastLat != newLocation.coordinate.latitude)|| (lastLng != newLocation.coordinate.longitude)){
        [defaults setFloat:newLocation.coordinate.latitude forKey:@"lat"];
        [defaults setFloat:newLocation.coordinate.longitude forKey:@"lng"];
        [defaults synchronize];
    }
}


- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

@end
