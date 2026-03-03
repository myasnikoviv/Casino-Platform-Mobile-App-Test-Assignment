import 'package:equatable/equatable.dart';

/// UI-ready game model with presentation-safe formatted values.
class CPGameViewModel extends Equatable {
  /// Creates [CPGameViewModel].
  const CPGameViewModel({
    required this.id,
    required this.name,
    required this.categoryLabel,
    required this.providerLabel,
    required this.rtpLabel,
    required this.volatilityLabel,
    required this.description,
    required this.thumbnailUrl,
    required this.headerUrl,
  });

  /// Game ID.
  final String id;

  /// Game name label.
  final String name;

  /// Localized category label.
  final String categoryLabel;

  /// Provider field label.
  final String providerLabel;

  /// Formatted RTP label.
  final String rtpLabel;

  /// Localized volatility label.
  final String volatilityLabel;

  /// Description ready for UI.
  final String description;

  /// Thumbnail URL.
  final String thumbnailUrl;

  /// Header image URL.
  final String headerUrl;

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        categoryLabel,
        providerLabel,
        rtpLabel,
        volatilityLabel,
        description,
        thumbnailUrl,
        headerUrl,
      ];
}
