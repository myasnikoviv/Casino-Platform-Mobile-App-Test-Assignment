import 'package:flutter/material.dart';

/// Icon token set used across the app.
enum CPIconType {
  home(Icons.home),
  homeOutlined(Icons.home_outlined),
  games(Icons.casino),
  gamesOutlined(Icons.casino_outlined),
  profile(Icons.person),
  profileOutlined(Icons.person_outline),
  fingerprint(Icons.fingerprint),
  copy(Icons.copy),
  warning(Icons.warning_amber_rounded);

  const CPIconType(this.data);

  final IconData data;
}
