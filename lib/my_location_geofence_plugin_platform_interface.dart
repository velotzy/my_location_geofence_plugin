import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_location_geofence_plugin_method_channel.dart';

abstract class MyLocationGeofencePluginPlatform extends PlatformInterface {
  /// Constructs a MyLocationGeofencePluginPlatform.
  MyLocationGeofencePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyLocationGeofencePluginPlatform _instance = MethodChannelMyLocationGeofencePlugin();

  /// The default instance of [MyLocationGeofencePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyLocationGeofencePlugin].
  static MyLocationGeofencePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyLocationGeofencePluginPlatform] when
  /// they register themselves.
  static set instance(MyLocationGeofencePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
