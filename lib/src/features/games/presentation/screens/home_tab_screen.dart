import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/domain/entities/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/presentation/widgets/games_grid.dart';
import 'package:casino_platform_test/src/features/games/presentation/widgets/promo_carousel.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_error_state.dart';
import 'package:casino_platform_test/src/shared/widgets/app_loading_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Home tab containing hero banners and game grid section.
class HomeTabScreen extends StatelessWidget {
  /// Route segment for home tab.
  static const String routeSegment = 'home';

  /// Creates [HomeTabScreen].
  const HomeTabScreen({super.key});

  void _onOpenGame(BuildContext context, GameViewModel game) {
    final String path = RoutePaths.gameDetails.replaceFirst(':gameId', game.id);
    context.push(path, extra: game);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesCubit, GamesState>(
      builder: (BuildContext context, GamesState state) {
        return RefreshIndicator(
          onRefresh: () => context.read<GamesCubit>().loadGames(context.l10n),
          child: ListView(
            cacheExtent: 600,
            padding: EdgeInsets.all(12.w),
            children: <Widget>[
              const PromoCarousel(),
              SizedBox(height: 14.h),
              Text(context.l10n.text('gamesTab'), style: AppTextStyles.h2),
              SizedBox(height: 10.h),
              if (state.status == GamesStatus.loading)
                const AppLoadingSkeleton(height: 320)
              else if (state.status == GamesStatus.error)
                AppErrorState(
                  message: state.errorMessage ??
                      context.l10n.text('unexpectedError'),
                  retryLabel: context.l10n.text('retry'),
                  onRetry: () =>
                      context.read<GamesCubit>().loadGames(context.l10n),
                )
              else
                GamesGrid(
                  games: state.games,
                  onOpenGame: (GameViewModel game) =>
                      _onOpenGame(context, game),
                ),
            ],
          ),
        );
      },
    );
  }
}
