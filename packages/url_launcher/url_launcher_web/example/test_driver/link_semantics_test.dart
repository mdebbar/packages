// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:webdriver/async_io.dart';

/// The following test is used as a simple smoke test for verifying Flutter
/// Framework and Flutter Web Engine integration.
void main() {
  group('Link Widget', () {
    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      await driver.close();
    });

    test('open link', () async {
      // await driver.setSemantics(true);
      // await Future<void>.delayed(const Duration(seconds: 5));

      await driver.webDriver.execute('console.log(document.querySelector("a").outerHTML)', <dynamic>[]);
      final WebElement link = await driver.webDriver.execute(
        'return document.querySelector("a")',
        <dynamic>[],
      ) as WebElement;
      await link.click();

      // await driver.tap(find.text('InternalLink1'));
      await Future<void>.delayed(const Duration(seconds: 10));
    });
  });
}
