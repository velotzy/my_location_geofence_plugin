
import 'my_location_geofence_plugin_platform_interface.dart';
import 'package:flutter/services.dart';

class MyLocationGeofencePlugin {
  static const MethodChannel _channel = MethodChannel('my_location_plugin');
  late EventChannel _eventChannel;

  static Future<void> startMonitoringPolygons(List<Map<String, dynamic>> polygons) async {
    print('monitor start');
    await _channel.invokeMethod('startMonitoringPolygons', {'polygons': polygons});
  }

  static Future<void> stopMonitoringPolygons() async {
    await _channel.invokeMethod('stopMonitoringPolygons');
  }

  // static Stream<dynamic> getLocationEvents() {
  //   return _eventChannel.receiveBroadcastStream();
  // }

  void initialize() {
    print('initialize');
    _eventChannel = EventChannel('location_events');
    _eventChannel.receiveBroadcastStream().listen((dynamic event) {
    print('Received event from native side: $event');
    // Handle the event as needed
  });
  }

  Future<String?> getPlatformVersion() {
    return MyLocationGeofencePluginPlatform.instance.getPlatformVersion();
  }
}
