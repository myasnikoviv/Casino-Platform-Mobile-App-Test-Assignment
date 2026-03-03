import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Utility for deterministic password hashing.
abstract final class CPHashUtils {
  /// Returns SHA-256 hash for a plaintext [input].
  static String sha256Of(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
