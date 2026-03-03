import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/domain/entities/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/presentation/widgets/game_detail_metrics.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_badge.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Game detail page with hero continuity from grid card.
class GameDetailScreen extends StatelessWidget {
  /// Route path for game details screen.
  static const String routePath = RoutePaths.gameDetails;

  /// Creates [GameDetailScreen].
  const GameDetailScreen({
    required this.gameId,
    this.extra,
    super.key,
  });

  /// Game id parsed from route params.
  final String gameId;

  /// Optional game model passed from source card.
  final GameViewModel? extra;

  GameViewModel? _resolveFromState(GamesState state) {
    for (final GameViewModel game in state.games) {
      if (game.id == gameId) {
        return game;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesCubit, GamesState>(
      builder: (BuildContext context, GamesState state) {
        final GameViewModel? game = extra ?? _resolveFromState(state);

        if (game == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.only(bottom: 20.h),
            children: <Widget>[
              SizedBox(
                height: 250.h,
                child: Hero(
                  tag: 'game-image-${game.id}',
                  child: Image.network(game.headerUrl, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(game.name, style: AppTextStyles.h1),
                    SizedBox(height: 8.h),
                    AppBadge(label: game.categoryLabel),
                    SizedBox(height: 14.h),
                    GameDetailMetrics(
                      provider: game.providerLabel,
                      rtp: game.rtpLabel,
                      volatility: game.volatilityLabel,
                    ),
                    SizedBox(height: 14.h),
                    Text(game.description, style: AppTextStyles.body),
                    SizedBox(height: 18.h),
                    AppButton(
                      label: context.l10n.text('playNow'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
