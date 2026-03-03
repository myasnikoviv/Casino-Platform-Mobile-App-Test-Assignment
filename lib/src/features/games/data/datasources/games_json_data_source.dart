import 'dart:convert';

import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:flutter/services.dart';

/// JSON-backed data source for mock games data.
class GamesJsonDataSource {
  /// Creates [GamesJsonDataSource].
  const GamesJsonDataSource();

  /// Loads game list from bundled mock JSON asset.
  Future<List<GameDto>> loadGames() async {
    final String raw = await rootBundle.loadString('assets/mock/games.json');
    final List<dynamic> jsonList = jsonDecode(raw) as List<dynamic>;
    return jsonList
        .map((dynamic item) => GameDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
