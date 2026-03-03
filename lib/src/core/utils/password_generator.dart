import 'dart:math';

/// Utility for generating strong random passwords.
abstract final class CPPasswordGenerator {
  static const String _alphabet =
      'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#%^&*';

  /// Generates a secure random password with [length].
  static String generate({int length = 14}) {
    final Random random = Random.secure();
    return String.fromCharCodes(
      Iterable<int>.generate(
        length,
        (_) => _alphabet.codeUnitAt(random.nextInt(_alphabet.length)),
      ),
    );
  }
}
