import 'package:casino_platform_test/src/features/games/data/gateways/games_api_gateway.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_local_gateway.dart';

/// Contract for games data retrieval.
abstract interface class CPGamesGateway {
  /// Returns game catalog.
  Future<List<CPGameDto>> getGames();
}

/// Gateway that orchestrates local and remote game gateways.
class CPGamesGatewayImpl implements CPGamesGateway {
  /// Creates [CPGamesGatewayImpl].
  const CPGamesGatewayImpl(this._localGateway, this._apiGateway);

  final CPGamesLocalGateway _localGateway;
  final CPGamesApiGateway _apiGateway;

  /// Returns game catalog from local gateway for assignment mode.
  @override
  Future<List<CPGameDto>> getGames() async {
    if (const bool.fromEnvironment('cp.useRemoteGames')) {
      return _apiGateway.fetchGames();
    }
    return _localGateway.loadGames();
  }
}
