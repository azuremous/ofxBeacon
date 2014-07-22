//
//  ofxBeaconDetector.cpp
//
//  Created by Kim jung un on 2014/06/26.
//
//

#include "ofxBeaconDetector.h"

@implementation ofxBeaconDetectorDelegate
@synthesize beaconSize;

-(id)init
{
    beacon = [[beaconDetector alloc] init];
    [beacon setDiscoveryDelegate:self];
    return self;
}

-(void)dealloc{
    [beacon release];
    beacon =nil;
    [super dealloc];
}

-(void)setBeacon:(NSString *)_beaconUUIDstring{
    beacon.myUUID = _beaconUUIDstring;
}

-(void)connect{
    
    [beacon connectAction];
}

-(BOOL)isInside { return [beacon isInside]; }

#pragma mark - delegate

-(void)alarmEnterRegion{ }

-(void)alarmExitRegion{ }

-(void)alarmBeaconSize:(NSUInteger)value{
    beaconSize = value;
    ofSendMessage("size"+ofToString((int)beaconSize));
}

-(void)alarmProximityStatus:(NSMutableArray *)status{
    for (int i = 0; i < beaconSize; i++){
        NSString *str = [status objectAtIndex:i];
        const char * _value = [str UTF8String];
        ofSendMessage(_value);
    }
}

-(void)alarmAccuracyStatus:(NSMutableArray *)status{
    for (int i = 0; i < beaconSize; i++){
        NSString *str = [status objectAtIndex:i];
        const char * _value = [str UTF8String];
        ofSendMessage(_value);
    }
}

-(void)alarmRssiStatus:(NSMutableArray *)status{
    for (int i = 0; i < beaconSize; i++){
        NSString *str = [status objectAtIndex:i];
        const char * _value = [str UTF8String];
        ofSendMessage(_value);
    }
}

-(void)alarmMajorValue:(NSMutableArray *)value{
    for (int i = 0; i < beaconSize; i++){
        NSString *str = [value objectAtIndex:i];
        const char * _value = [str UTF8String];
        ofSendMessage(_value);
    }
}

-(void)alarmMinorValue:(NSMutableArray *)value{
    for (int i = 0; i < beaconSize; i++){
        NSString *str = [value objectAtIndex:i];
        const char * _value = [str UTF8String];
        ofSendMessage(_value);
    }
}

@end;

//--------------------------------------------------------------
/*public */ofxBeaconDetector::ofxBeaconDetector()

{}

//--------------------------------------------------------------
/*public */void ofxBeaconDetector::setup(string _beaconUUID){
    _beacon = [[ofxBeaconDetectorDelegate alloc] init];
    [_beacon setBeacon:sToNS(_beaconUUID)];
}

//--------------------------------------------------------------
/*public */void ofxBeaconDetector::connect(){
    [_beacon connect];
}

//--------------------------------------------------------------
/*public */bool ofxBeaconDetector::isInside(){
    return [_beacon isInside];
}

//--------------------------------------------------------------
/*protected */NSString * ofxBeaconDetector::sToNS(string _s){ return [NSString stringWithFormat:@"%s",_s.c_str()]; }