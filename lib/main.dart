import 'package:admin/start-page.dart';
import 'package:flutter/material.dart';

import 'componants/componants.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StartPage(),
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
    ),
  ));
}
