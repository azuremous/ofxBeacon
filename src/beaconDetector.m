//
//  beaconDetector.m
//
//  Created by Kim jung un on 2014/06/26.
//
//

#import "beaconDetector.h"

@implementation beaconDetector

@synthesize myUUID;
@synthesize myIdentifier;
@synthesize discoveryDelegate;
@synthesize peripheralManager;
@synthesize isInside;

-(id)init{
    isInside = false;
    myIdentifier = @"ibeacon_example";
    [self initPM];
    return self;
}

#pragma mark - function

-(void)initPM{
    
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    
}

-(void)connectAction{
    NSLog(@"connect action");
    if([CLLocationManager isRangingAvailable]){
        
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:myUUID];
        beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:myIdentifier];
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        [self.locationManager startMonitoringForRegion:beaconRegion];
        
        
    }else{
        
        NSString *message = @"Your device dose not support ranging of Bluetooth beacons.";
        NSLog(@"%@", message);
        
    }
    
}

#pragma mark - CBPeripheralManagerDelegate

//  ---------------------------
//  CBPeripheralManagerDelegate
//  ---------------------------

// Monitoring Changes to the Peripheral Manager’s State

// peripheralManagerDidUpdateState:
// Invoked when the peripheral manager's state is updated. (required)

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"update pm");
    
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"power on");
            [self.peripheralManager startAdvertising:[beaconRegion peripheralDataWithMeasuredPower:nil]];
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"power off");
            break;
        case CBPeripheralManagerStateResetting:
            NSLog(@"pm resetting");
            break;
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"pm Unauthorized");
            break;
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"pm Unsupported");
            break;
        case CBPeripheralManagerStateUnknown:
            NSLog(@"pm Unknown");
            break;
    }
}

// peripheralManager:willRestoreState:
// Invoked when the peripheral manager is about to be restored by the system.
- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary *)dict
{
    
}

// Adding Services

// peripheralManager:didAddService:error:
// Invoked when you publish a service, and any of its associated characteristics and characteristic descriptors, to the local Generic Attribute Profile (GATT) database.
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    
}

// Advertising Peripheral Data

// peripheralManagerDidStartAdvertising:error:
// Invoked when you start advertising the local peripheral device’s data.
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    
    if(error){ NSLog(@"error: %@", [error localizedDescription]); }
    else{ NSLog(@"now advertising..."); } //normal status
}

// Monitoring Subscriptions to Characteristic Values

// peripheralManager:central:didSubscribeToCharacteristic:
// Invoked when a remote central device subscribes to a characteristic’s value.
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    
}

// peripheralManager:central:didUnsubscribeFromCharacteristic:
// Invoked when a remote central device unsubscribes from a characteristic’s value.
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    
}

// peripheralManagerIsReadyToUpdateSubscribers:
// Invoked when a local peripheral device is again ready to send characteristic value updates. (required)
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    
}

// Receiving Read and Write Requests

// peripheralManager:didReceiveReadRequest:
// Invoked when a local peripheral device receives an Attribute Protocol (ATT) read request for a characteristic that has a dynamic value.
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
   
}

// peripheralManager:didReceiveWriteRequests:
// Invoked when a local peripheral device receives an Attribute Protocol (ATT) write request for a characteristic that has a dynamic value.
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests
{
    
}

#pragma mark - CLLocationManagerDelegate

//  -------------------------
//  CLLocationManagerDelegate
//  -------------------------

// Responding to Location Events

// locationManager:didUpdateLocations:
// Tells the delegate that new location data is available.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
   
}

// locationManager:didFailWithError:
// Tells the delegate that the location manager was unable to retrieve a location value.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

// locationManager:didFinishDeferredUpdatesWithError:
// Tells the delegate that updates will no longer be deferred.
- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    
}

// Pausing Location Updates

// locationManagerDidPauseLocationUpdates:
// Tells the delegate that location updates were paused. (required)
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    
}

// locationManagerDidResumeLocationUpdates:
// Tells the delegate that the delivery of location updates has resumed. (required)
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
    
}

// Responding to Heading Events

// locationManager:didUpdateHeading:
// Tells the delegate that the location manager received updated heading information.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
   
}

// locationManagerShouldDisplayHeadingCalibration:
// Asks the delegate whether the heading calibration alert should be displayed.
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}

// Responding to Region Events

// locationManager:didEnterRegion:
// Tells the delegate that the user entered the specified region.
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
    if([region isKindOfClass:[CLBeaconRegion class]]){
        [discoveryDelegate alarmEnterRegion];
    }
}

// locationManager:didExitRegion:
// Tells the delegate that the user left the specified region.
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    if([region isKindOfClass:[CLBeaconRegion class]]){
        [discoveryDelegate alarmExitRegion];
        //NSString *regionIdentifer = region.identifier;
    }
}

// locationManager:didDetermineState:forRegion:
// Tells the delegate about the state of the specified region. (required)
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    
    NSString *stateString = @"";
    switch (state) {
        case CLRegionStateUnknown:
            stateString = @"CLRegionStateUnknown";
            break;
        case CLRegionStateInside:
            stateString = @"CLRegionStateInside";
            [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
            break;
        case CLRegionStateOutside:
            stateString = @"CLRegionStateOutside";
            break;
        default:
            stateString = @"???";
            break;
    }
    
    NSLog(@"%@", stateString);
}

// locationManager:monitoringDidFailForRegion:withError:
// Tells the delegate that a region monitoring error occurred.
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    if(error){}
}

// locationManager:didStartMonitoringForRegion:
// Tells the delegate that a new region is being monitored.
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.locationManager requestStateForRegion:region];
}

// Responding to Ranging Events

// locationManager:didRangeBeacons:inRegion:
// Tells the delegate that one or more beacons are in range. (required)
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
    CLProximity proximity = CLProximityUnknown;
    CLLocationAccuracy locationAccuracy = -1;
    NSInteger rssi = 0;
    NSNumber *_major = 0;
    NSNumber *_minor = 0;
    
    NSLog(@"[beacons count] = %ld", (unsigned long)[beacons count]);
    NSMutableArray * beaconMajorList = [NSMutableArray array];
    NSMutableArray * beaconMinorList = [NSMutableArray array];
    NSMutableArray * beaconProximityList = [NSMutableArray array];
    NSMutableArray * beaconAccuracyList = [NSMutableArray array];
    NSMutableArray * beaconRssiList = [NSMutableArray array];
    [beaconMajorList removeAllObjects];
    [beaconMinorList removeAllObjects];
    [beaconProximityList removeAllObjects];
    [beaconAccuracyList removeAllObjects];
    [beaconRssiList removeAllObjects];
    
    [discoveryDelegate alarmBeaconSize:[beacons count]];
    
    for(CLBeacon *b in beacons){
        proximity = b.proximity;
        locationAccuracy = b.accuracy;
        rssi = b.rssi;
        _major = b.major;
        _minor = b.minor;
        
        NSString *proximityString = @"";
        
        switch (proximity) {
            case CLProximityUnknown:
                proximityString = @"CLProximityUnknown";
                break;
            case CLProximityImmediate:
                proximityString = @"CLProximityImmediate";
                break;
            case CLProximityNear:
                proximityString = @"CLProximityNear";
                break;
            case CLProximityFar:
                proximityString = @"CLProximityFar";
                break;
            default:
                proximityString = @"???";
                break;
        }
        isInside = true;
        NSString * proximityText = [NSString stringWithFormat:@"Proximity: %@", proximityString];
        NSString * accuracyText = [NSString stringWithFormat:@"Accuracy: %f", locationAccuracy];
        NSString * rssiText = [NSString stringWithFormat:@"RSSI: %ld", (long)rssi];
        NSString * majorText = [NSString stringWithFormat:@"Major: %@", _major];
        NSString * minorText = [NSString stringWithFormat:@"Minor: %@", _minor];
        
        NSLog(@"major:%@ minor:%@",_major, _minor);
        NSLog(@"%@  %@",proximityText, accuracyText);
        
        [beaconMajorList addObject:majorText];
        [beaconMinorList addObject:minorText];
        [beaconProximityList addObject:proximityText];
        [beaconAccuracyList addObject:accuracyText];
        [beaconRssiList addObject:rssiText];
        
    }
    
    [discoveryDelegate alarmMajorValue:beaconMajorList];
    [discoveryDelegate alarmMinorValue:beaconMinorList];
    [discoveryDelegate alarmProximityStatus:beaconProximityList];
    [discoveryDelegate alarmAccuracyStatus:beaconAccuracyList];
    [discoveryDelegate alarmRssiStatus:beaconRssiList];
    
}

// locationManager:rangingBeaconsDidFailForRegion:withError:
// Tells the delegate that an error occurred while gathering ranging information for a set of beacons. (required)
- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    
}

// Responding to Authorization Changes

// locationManager:didChangeAuthorizationStatus:
// Tells the delegate that the authorization status for the application changed.
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%s", __func__);
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusAuthorized:
            NSLog(@"kCLAuthorizationStatusAuthorized");
            break;
        default:
            break;
    }
}

@end
