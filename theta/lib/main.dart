import 'package:flutter/material.dart' show runApp;
import 'package:theta_module/app.dart' deferred as app;
import 'package:theta_module/error_screen.dart' deferred as error;

Future<void> main() async {
  try {
    app.loadLibrary().then((_) {
      runApp(app.MyApp(name: '', token: ''));
    });
  } catch (e) {
    print(e);
    error.loadLibrary().then((_) {
      runApp(error.ErrorScreen());
    });
  }
}
