//
//  ofxBeaconDetector.h
//
//  Created by Kim jung un on 2014/06/26.
//
//

#pragma once
#import <Foundation/Foundation.h>
#import "ofMain.h"
#import "beaconDetector.h"

@interface ofxBeaconDetectorDelegate : UIViewController<alarmBeaconDelegate>
{
    beaconDetector * beacon;
}

@property NSInteger beaconSize;

-(id)init;
-(void)setBeacon:(NSString *)_beaconUUIDstring;
-(void)connect;
-(BOOL)isInside;

@end


class ofxBeaconDetector {

private:
    ofxBeaconDetectorDelegate * _beacon;
protected:
    NSString * sToNS(string _s);
public:
    explicit ofxBeaconDetector();
    void setup(string _beaconUUID);
    void connect();
    bool isInside();
};