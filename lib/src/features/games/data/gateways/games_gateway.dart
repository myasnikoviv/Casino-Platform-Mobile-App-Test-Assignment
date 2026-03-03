import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';

/// Contract for games data retrieval.
abstract interface class CPGamesGateway {
  /// Returns game catalog.
  Future<List<CPGameDto>> getGames();
}
