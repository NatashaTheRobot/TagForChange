//
//  BeaconManager.m
//  TagForChange
//
//  Created by Natasha Murashev on 12/7/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "BeaconManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BeaconManager() <CBPeripheralManagerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *beaconRegions;

@end

@implementation BeaconManager

static BeaconManager *beaconManager;

+ (instancetype)sharedManager
{
    if (!beaconManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            beaconManager = [[BeaconManager alloc] init];
        });
        
    }
    
    return beaconManager;
}

- (id)init
{
    self = [super init];
    
    [self initBeacon];
    [self trasmitBeacon];
    // start monitoriing for beacons!
    
    return self;
}

- (void)initBeacon
{
    TFCUser *user = [TFCUser currentUser];
    if (user) {
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:user.uuidString]
                                                               identifier:user.objectId];
    }
}

- (void)trasmitBeacon
{
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        if (![self.peripheralManager isAdvertising]) {
            [self.peripheralManager startAdvertising:self.beaconPeripheralData];
        }
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        [self.peripheralManager stopAdvertising];
    }
}

#pragma mark - iBeacon Detection

//- (void)startMonitoringRegionForAttendee:(PFObject *)attendee
//{
//    NSString *attendeeUUID = attendee[sParseClassAttendeeKeyUUID];
//    if (attendeeUUID) {
//        NSUUID *uuid =[[NSUUID alloc] initWithUUIDString:attendeeUUID];
//        NSString *regionIdentifier = [NSString stringWithFormat:@"%@.%@", HOLLER_BEACON_IDENTIFIER, attendee[sParseClassAttendeeKeyEmail]];
//        CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
//                                                                          identifier:regionIdentifier];
//        
//        if (beaconRegion) {
//            [self.locationManager startMonitoringForRegion:beaconRegion];
//            self.beaconRegions[regionIdentifier] = beaconRegion;
//        }
//    }
//}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegions[region.identifier]];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegions[region.identifier]];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
//    CLBeacon *beacon = [beacons lastObject];
//    PFQuery *query = [PFQuery queryWithClassName:sParseClassAttendee];
//    NSString *beaconUUID = [beacon.proximityUUID UUIDString];
//    
//    if (beaconUUID) {
//        [query whereKey:sParseClassAttendeeKeyUUID equalTo:[beacon.proximityUUID UUIDString]];
//        __weak AttendeeListViewController *weakSelf = self;
//        
//        if (beacon && (beacon.proximity == CLProximityImmediate || beacon.proximity == CLProximityNear || beacon.proximity == CLProximityFar))
//        {
//            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                if (objects && objects.count > 0) {
//                    PFObject *attendee = [objects lastObject];
//                    
//                    NSPredicate *attendeeFilter = [NSPredicate predicateWithFormat:@"objectId == %@", attendee.objectId];
//                    NSArray *attendeeResults = [weakSelf.nearbyAttendees filteredArrayUsingPredicate:attendeeFilter];
//                    if (attendeeResults.count == 0) {
//                        [weakSelf.nearbyAttendees addObject:attendee];
//                        [weakSelf.tableView reloadData];
//                    }
//                }
//            }];
//        }
//        else
//        {
//            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                if (objects && objects.count > 0) {
//                    PFObject *attendee = [objects lastObject];
//                    
//                    NSPredicate *attendeeFilter = [NSPredicate predicateWithFormat:@"objectId == %@", attendee.objectId];
//                    NSArray *attendeeResults = [weakSelf.nearbyAttendees filteredArrayUsingPredicate:attendeeFilter];
//                    if (attendeeResults.count > 0) {
//                        PFObject *attendeeNearby = [attendeeResults lastObject];
//                        [weakSelf.nearbyAttendees removeObject:attendeeNearby];
//                        [weakSelf.tableView reloadData];
//                    }
//                }
//            }];
//            
//        }
//        
//    }
}

@end
