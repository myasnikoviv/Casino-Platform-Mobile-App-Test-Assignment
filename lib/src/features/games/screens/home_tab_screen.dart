import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/entities/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/components/games_grid.dart';
import 'package:casino_platform_test/src/features/games/components/promo_carousel.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_error_state.dart';
import 'package:casino_platform_test/src/shared/widgets/app_loading_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Home tab containing hero banners and game grid section.
class CPHomeTabScreen extends StatelessWidget {
  /// Route segment for home tab.
  static const String routeSegment = 'home';

  /// Creates [CPHomeTabScreen].
  const CPHomeTabScreen({super.key});

  void _onOpenGame(BuildContext context, CPGameViewModel game) {
    final String path =
        CPRoutePaths.gameDetails.replaceFirst(':gameId', game.id);
    context.pushRoute(path, extra: game);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPGamesCubit, CPGamesState>(
      builder: (BuildContext context, CPGamesState state) {
        return RefreshIndicator(
          onRefresh: () => context.read<CPGamesCubit>().loadGames(context.l10n),
          child: ListView(
            cacheExtent: 600,
            padding: EdgeInsets.all(12.w),
            children: <Widget>[
              const CPPromoCarousel(),
              SizedBox(height: 14.h),
              Text(context.l10n.text('gamesTab'), style: CPAppTextStyles.h2),
              SizedBox(height: 10.h),
              if (state.status == CPGamesStatus.loading)
                const CPAppLoadingSkeleton(height: 320)
              else if (state.status == CPGamesStatus.error)
                CPAppErrorState(
                  message: state.errorMessage ??
                      context.l10n.text('unexpectedError'),
                  retryLabel: context.l10n.text('retry'),
                  onRetry: () =>
                      context.read<CPGamesCubit>().loadGames(context.l10n),
                )
              else
                CPGamesGrid(
                  games: state.games,
                  onOpenGame: (CPGameViewModel game) =>
                      _onOpenGame(context, game),
                ),
            ],
          ),
        );
      },
    );
  }
}
