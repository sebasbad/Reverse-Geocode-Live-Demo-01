//
//  ViewController.m
//  Reverse Geocode Live Demo 01
//
//  Created by Sebastián Badea on 1/4/16.
//  Copyright © 2016 Sebastian Badea. All rights reserved.
//

#import "MapKit/MapKit.h"
#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CLGeocoder *geocoder;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *reverseGeocodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pinIconImageView;

@property (assign, nonatomic) BOOL lookup;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.geocoder = [[CLGeocoder alloc] init];
    
    self.reverseGeocodeLabel.text = nil;
    self.reverseGeocodeLabel.alpha = 0.5;
    
    self.lookup = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)executeLookup {
    
    if (NO == self.lookup) {
        CLLocationCoordinate2D coordinates = [self locationAtCenterOfMapView];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
        [self startReverseGeocodeLocation:location];
    }
}

- (CLLocationCoordinate2D)locationAtCenterOfMapView {
    
    // The center in ImageView coord space
    CGPoint centerOfPin = CGPointMake(CGRectGetMidX(self.pinIconImageView.bounds), CGRectGetMidY(self.pinIconImageView.bounds));
    
    CLLocationCoordinate2D centerOfPinInMap = [self.mapView convertPoint:centerOfPin toCoordinateFromView:self.pinIconImageView];
    
    return centerOfPinInMap;
}

- (void)startReverseGeocodeLocation:(CLLocation *)location {
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"There was a problem reverse geocoding" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        // Gran some interesting bits of CLPlacemark and show it. But no dupes.
        NSMutableSet *mappedPlacesDescriptions = [NSMutableSet new];
        
        for (CLPlacemark *placemark in placemarks) {
            if (nil != placemark.name) {
                [mappedPlacesDescriptions addObject:placemark.name];
            }
            if (nil != placemark.administrativeArea) {
                [mappedPlacesDescriptions addObject:placemark.administrativeArea];
            }
            if (nil != placemark.country) {
                [mappedPlacesDescriptions addObject:placemark.country];
            }
            
            [mappedPlacesDescriptions addObjectsFromArray:placemark.areasOfInterest];
        }
        
        self.reverseGeocodeLabel.text = [[mappedPlacesDescriptions allObjects] componentsJoinedByString:@"\n"];
        self.reverseGeocodeLabel.alpha = 1.0;
    }];
}

@end
