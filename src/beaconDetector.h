//
//  beaconDetector.h
//
//  Created by Kim jung un on 2014/06/26.
//
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@class alarmBeacon;
@protocol alarmBeaconDelegate <NSObject>

-(void)alarmEnterRegion;
-(void)alarmExitRegion;

-(void)alarmMajorValue:(NSMutableArray *)value;
-(void)alarmMinorValue:(NSMutableArray *)value;
-(void)alarmProximityStatus:(NSMutableArray *)status;
-(void)alarmAccuracyStatus:(NSMutableArray *)status;
-(void)alarmRssiStatus:(NSMutableArray *)status;
-(void)alarmBeaconSize:(NSUInteger)value;
@end



@interface beaconDetector : NSObject <CBPeripheralManagerDelegate, CLLocationManagerDelegate>
{
    CLBeaconRegion *beaconRegion;
}

@property(nonatomic, assign) id <alarmBeaconDelegate> discoveryDelegate;
@property(nonatomic, retain) NSString * myUUID;
@property(nonatomic, retain) NSString * myIdentifier;
@property CBPeripheralManager *peripheralManager;
@property CLLocationManager * locationManager;
@property(readonly) BOOL isInside;

-(void)connectAction;
-(void)initPM;

@end
