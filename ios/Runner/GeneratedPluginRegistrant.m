//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <geocoder/GeocoderPlugin.h>
#import <geolocator/GeolocatorPlugin.h>
#import <google_api_availability/GoogleApiAvailabilityPlugin.h>
#import <location_permissions/LocationPermissionsPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [GeocoderPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeocoderPlugin"]];
  [GeolocatorPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeolocatorPlugin"]];
  [GoogleApiAvailabilityPlugin registerWithRegistrar:[registry registrarForPlugin:@"GoogleApiAvailabilityPlugin"]];
  [LocationPermissionsPlugin registerWithRegistrar:[registry registrarForPlugin:@"LocationPermissionsPlugin"]];
}

@end
