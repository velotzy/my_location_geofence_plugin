import 'package:flutter_test/flutter_test.dart';
import 'package:my_location_geofence_plugin/my_location_geofence_plugin.dart';
import 'package:my_location_geofence_plugin/my_location_geofence_plugin_platform_interface.dart';
import 'package:my_location_geofence_plugin/my_location_geofence_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyLocationGeofencePluginPlatform
    with MockPlatformInterfaceMixin
    implements MyLocationGeofencePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyLocationGeofencePluginPlatform initialPlatform = MyLocationGeofencePluginPlatform.instance;

  test('$MethodChannelMyLocationGeofencePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyLocationGeofencePlugin>());
  });

  test('getPlatformVersion', () async {
    MyLocationGeofencePlugin myLocationGeofencePlugin = MyLocationGeofencePlugin();
    MockMyLocationGeofencePluginPlatform fakePlatform = MockMyLocationGeofencePluginPlatform();
    MyLocationGeofencePluginPlatform.instance = fakePlatform;

    // expect(await myLocationGeofencePlugin.getPlatformVersion(), '42');
  });
}
