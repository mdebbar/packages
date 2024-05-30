// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_web/src/link.dart';
// import 'package:url_launcher_web/url_launcher_web.dart';

final Uri internalUri = Uri.parse('/foo/bar');
final Uri externalUri = Uri.parse('https://flutter.dev');

void main() {
  enableFlutterDriverExtension();


  runApp(
    MaterialApp(
      routes: <String, WidgetBuilder>{
        internalUri.path: (BuildContext context) => HomePage('Internal Page'),
      },
      home: HomePage('Home Page'),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            ExcludeSemantics(child: Text(title)),
            WebLinkDelegate(TestLinkInfo(
              uri: internalUri,
              target: LinkTarget.blank,
              builder: (BuildContext context, FollowLink? followLink) {
                return ElevatedButton(
                  onPressed: followLink,
                  child: const Text('InternalLink1'),
                );
              },
            )),
            WebLinkDelegate(TestLinkInfo(
              uri: internalUri,
              target: LinkTarget.blank,
              builder: (BuildContext context, FollowLink? followLink) {
                return const Text('InternalLink2');
              },
            )),
            WebLinkDelegate(TestLinkInfo(
              uri: externalUri,
              target: LinkTarget.blank,
              builder: (BuildContext context, FollowLink? followLink) {
                return ElevatedButton(
                  onPressed: followLink,
                  child: const Text('ExternalLink1'),
                );
              },
            )),
            WebLinkDelegate(TestLinkInfo(
              uri: externalUri,
              target: LinkTarget.blank,
              builder: (BuildContext context, FollowLink? followLink) {
                return const Text('ExternalLink2');
              },
            )),
          ],
        ),
    );
  }
}

class TestLinkInfo extends LinkInfo {
  TestLinkInfo({
    required this.uri,
    required this.target,
    required this.builder,
  });

  @override
  final LinkWidgetBuilder builder;

  @override
  final Uri? uri;

  @override
  final LinkTarget target;

  @override
  bool get isDisabled => uri == null;
}
