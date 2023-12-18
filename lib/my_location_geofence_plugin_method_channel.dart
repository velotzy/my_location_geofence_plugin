import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_location_geofence_plugin_platform_interface.dart';

/// An implementation of [MyLocationGeofencePluginPlatform] that uses method channels.
class MethodChannelMyLocationGeofencePlugin extends MyLocationGeofencePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_location_geofence_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
