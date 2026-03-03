import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/ui/components/game_detail_metrics.dart';
import 'package:casino_platform_test/src/features/main_shell/ui/screens/main_shell_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_badge.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Game detail page with hero continuity from grid card.
class CPGameDetailScreen extends StatelessWidget {
  /// Route chunk for game details screen.
  static const String pathChunk = 'game/:gameId';

  /// Builds route path for selected [gameId].
  static CPRoutePath pathForId(String gameId) {
    return CPRoutePath(
        CPMainShellScreen.routePath.fullPath, <String>['game/$gameId']);
  }

  /// Creates [CPGameDetailScreen].
  const CPGameDetailScreen({
    required this.gameId,
    this.extra,
    super.key,
  });

  /// Game id parsed from route params.
  final String gameId;

  /// Optional game model passed from source card.
  final CPGameViewModel? extra;

  CPGameViewModel? _resolveFromState(CPGamesState state) {
    if (state is! CPGamesSuccessState) {
      return null;
    }
    for (final CPGameViewModel game in state.games) {
      if (game.id == gameId) {
        return game;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPGamesCubit, CPGamesState>(
      builder: (BuildContext context, CPGamesState state) {
        final CPGameViewModel? game = extra ?? _resolveFromState(state);

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
                    Text(game.name, style: CPAppTextStyles.h1),
                    SizedBox(height: 8.h),
                    CPAppBadge(label: game.categoryLabel),
                    SizedBox(height: 14.h),
                    CPGameDetailMetrics(
                      provider: game.providerLabel,
                      rtp: game.rtpLabel,
                      volatility: game.volatilityLabel,
                    ),
                    SizedBox(height: 14.h),
                    Text(game.description, style: CPAppTextStyles.body),
                    SizedBox(height: 18.h),
                    CPAppButton(
                      label: context.l10n.playNow,
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
