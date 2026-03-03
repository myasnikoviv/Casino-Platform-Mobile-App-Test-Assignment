import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';

/// Contract for local games data source.
abstract interface class CPGamesLocalGateway {
  /// Loads games from local source.
  Future<List<CPGameDto>> loadGames();
}
