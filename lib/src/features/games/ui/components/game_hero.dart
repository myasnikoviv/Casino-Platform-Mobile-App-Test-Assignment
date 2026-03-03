import 'package:flutter/widgets.dart';

/// Shared hero tags for games flow.
abstract final class CPGameHeroTags {
  /// Hero tag for game image by [gameId].
  static String gameImage(String gameId) => 'game-image-$gameId';
}

/// Shared hero wrapper for game images.
class CPGameImageHero extends StatelessWidget {
  /// Creates [CPGameImageHero].
  const CPGameImageHero({
    required this.gameId,
    required this.child,
    super.key,
  });

  /// Unique game id for hero continuity.
  final String gameId;

  /// Hero child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: CPGameHeroTags.gameImage(gameId),
      child: child,
    );
  }
}
