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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.geocoder = [[CLGeocoder alloc] init];
    
    self.reverseGeocodeLabel.text = nil;
    self.reverseGeocodeLabel.alpha = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reverseGeocodeTapped:(id)sender {
}

- (CLLocationCoordinate2D)locationAtCenterOfMapView {
    
    // The center in ImageView coord space
    CGPoint centerOfPin = CGPointMake(CGRectGetMidX(self.pinIconImageView.bounds), CGRectGetMidY(self.pinIconImageView.bounds));
    
    CLLocationCoordinate2D centerOfPinInMap = [self.mapView convertPoint:centerOfPin toCoordinateFromView:self.pinIconImageView];
    
    return centerOfPinInMap;
}

@end
