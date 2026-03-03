import 'package:equatable/equatable.dart';

/// View-ready user session model consumed by presentation layer.
class UserSession extends Equatable {
  /// Creates [UserSession].
  const UserSession({
    required this.id,
    required this.fullName,
    required this.email,
    required this.memberSince,
  });

  /// User ID.
  final String id;

  /// Full name.
  final String fullName;

  /// Email.
  final String email;

  /// Formatted member since date.
  final String memberSince;

  /// Initials used by profile avatar.
  String get initials {
    final List<String> chunks = fullName
        .trim()
        .split(' ')
        .where((String item) => item.isNotEmpty)
        .toList();
    if (chunks.isEmpty) {
      return 'U';
    }
    if (chunks.length == 1) {
      return chunks.first.substring(0, 1).toUpperCase();
    }
    return '${chunks.first.substring(0, 1)}${chunks.last.substring(0, 1)}'
        .toUpperCase();
  }

  @override
  List<Object?> get props => <Object?>[id, fullName, email, memberSince];
}
