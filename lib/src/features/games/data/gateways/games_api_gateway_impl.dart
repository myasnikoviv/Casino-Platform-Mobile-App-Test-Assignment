import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_api_gateway.dart';

/// Placeholder API gateway implementation for future Dio/Retrofit integration.
class CPGamesApiGatewayImpl implements CPGamesApiGateway {
  /// Creates [CPGamesApiGatewayImpl].
  const CPGamesApiGatewayImpl();

  @override
  Future<List<CPGameDto>> fetchGames() async {
    throw UnimplementedError(
        'Remote games API is not configured for this assignment.');
  }
}
