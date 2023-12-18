import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_location_geofence_plugin/my_location_geofence_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMyLocationGeofencePlugin platform = MethodChannelMyLocationGeofencePlugin();
  const MethodChannel channel = MethodChannel('my_location_geofence_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
