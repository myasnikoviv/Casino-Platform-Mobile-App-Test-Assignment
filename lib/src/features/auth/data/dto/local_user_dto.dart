/// DTO representing a locally persisted user.
class LocalUserDto {
  /// Creates [LocalUserDto].
  const LocalUserDto({
    required this.id,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    required this.createdAtIso,
  });

  /// Unique user identifier.
  final String id;

  /// Full name entered at registration.
  final String fullName;

  /// User email used as login.
  final String email;

  /// Hashed password value.
  final String passwordHash;

  /// Account creation timestamp in ISO format.
  final String createdAtIso;

  /// Converts DTO to map for persistence.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'passwordHash': passwordHash,
      'createdAtIso': createdAtIso,
    };
  }

  /// Creates DTO from persisted map.
  factory LocalUserDto.fromMap(Map<dynamic, dynamic> map) {
    return LocalUserDto(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      passwordHash: map['passwordHash'] as String,
      createdAtIso: map['createdAtIso'] as String,
    );
  }
}
