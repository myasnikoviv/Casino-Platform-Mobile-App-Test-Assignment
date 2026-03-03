import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';

/// Placeholder remote API gateway for future Dio/Retrofit integration.
class CPGamesApiGateway implements CPGamesGateway {
  /// Creates [CPGamesApiGateway].
  const CPGamesApiGateway();

  @override
  Future<List<CPGameDto>> getGames() async {
    throw UnimplementedError(
      'Remote games API is not configured for this assignment.',
    );
  }
}
