import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';

/// Adapter that maps raw game DTOs into UI view models.
class CPGameViewModelAdapter {
  /// Creates [CPGameViewModelAdapter].
  const CPGameViewModelAdapter();

  /// Adapts [dto] into view model with localized labels.
  CPGameViewModel adapt(CPGameDto dto, AppLocalizations l10n) {
    return CPGameViewModel(
      id: dto.id,
      name: dto.name,
      categoryLabel: dto.category.label(l10n),
      providerLabel: dto.provider,
      rtpLabel: '${dto.rtp.toStringAsFixed(2)}%',
      volatilityLabel: dto.volatility.label(l10n),
      description: dto.description,
      thumbnailUrl: dto.thumbnailUrl,
      headerUrl: dto.headerUrl,
    );
  }
}
