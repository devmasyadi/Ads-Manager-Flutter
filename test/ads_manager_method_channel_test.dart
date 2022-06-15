import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ads_manager/ads_manager_method_channel.dart';

void main() {
  MethodChannelAdsManager platform = MethodChannelAdsManager();
  const MethodChannel channel = MethodChannel('ads_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
