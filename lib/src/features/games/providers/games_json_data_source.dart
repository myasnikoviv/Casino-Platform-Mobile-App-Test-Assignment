import 'dart:convert';

import 'package:casino_platform_test/src/features/games/entities/game_dto.dart';
import 'package:flutter/services.dart';

/// JSON-backed data source for mock games data.
class CPGamesJsonDataSource {
  /// Creates [CPGamesJsonDataSource].
  const CPGamesJsonDataSource();

  /// Loads game list from bundled mock JSON asset.
  Future<List<CPGameDto>> loadGames() async {
    final String raw = await rootBundle.loadString('assets/mock/games.json');
    final List<dynamic> jsonList = jsonDecode(raw) as List<dynamic>;
    return jsonList
        .map((dynamic item) => CPGameDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
