import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

Widget wrapTestApp(Widget child) {
  return Provider<CookieRequest>(
    create: (_) => CookieRequest(),
    child: MaterialApp(home: child),
  );
}
