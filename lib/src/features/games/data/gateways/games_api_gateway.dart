import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';

/// Contract for remote games API gateway.
abstract interface class CPGamesApiGateway {
  /// Loads games from remote API.
  Future<List<CPGameDto>> fetchGames();
}
