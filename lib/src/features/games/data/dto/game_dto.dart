import 'package:casino_platform_test/src/shared/enums/game_category.dart';
import 'package:casino_platform_test/src/shared/enums/volatility_level.dart';

/// Raw game DTO loaded from JSON data source.
class GameDto {
  /// Creates [GameDto].
  const GameDto({
    required this.id,
    required this.name,
    required this.category,
    required this.provider,
    required this.rtp,
    required this.volatility,
    required this.description,
    required this.thumbnailUrl,
    required this.headerUrl,
  });

  /// Unique game identifier.
  final String id;

  /// Game title.
  final String name;

  /// Game category enum.
  final GameCategory category;

  /// Provider name.
  final String provider;

  /// RTP value as double.
  final double rtp;

  /// Volatility level.
  final VolatilityLevel volatility;

  /// Description text.
  final String description;

  /// Small card image URL.
  final String thumbnailUrl;

  /// Large detail header image URL.
  final String headerUrl;

  /// Creates DTO from JSON map.
  factory GameDto.fromJson(Map<String, dynamic> json) {
    return GameDto(
      id: json['id'] as String,
      name: json['name'] as String,
      category: GameCategory.fromRaw(json['category'] as String),
      provider: json['provider'] as String,
      rtp: (json['rtp'] as num).toDouble(),
      volatility: VolatilityLevel.fromRaw(json['volatility'] as String),
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      headerUrl: json['headerUrl'] as String,
    );
  }
}
