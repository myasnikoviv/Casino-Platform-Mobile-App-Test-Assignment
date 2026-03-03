import 'dart:convert';

import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:flutter/services.dart';

/// Local gateway that loads mock games from bundled JSON.
class CPGamesLocalGateway implements CPGamesGateway {
  /// Creates [CPGamesLocalGateway].
  const CPGamesLocalGateway();

  /// Loads games from bundled mock JSON asset.
  @override
  Future<List<CPGameDto>> getGames() async {
    final String raw = await rootBundle.loadString('assets/mock/games.json');
    final List<dynamic> jsonList = jsonDecode(raw) as List<dynamic>;
    return jsonList
        .map((dynamic item) => CPGameDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
