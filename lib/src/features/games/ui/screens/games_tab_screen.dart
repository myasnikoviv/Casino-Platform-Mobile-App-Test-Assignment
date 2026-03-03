import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/ui/components/games_grid.dart';
import 'package:casino_platform_test/src/features/games/ui/screens/game_detail_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_error_state.dart';
import 'package:casino_platform_test/src/shared/ui/app_loading_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Dedicated games tab with full catalog grid.
class CPGamesTabScreen extends StatelessWidget {
  /// Route segment for games tab.
  static const String routeSegment = 'games';

  /// Creates [CPGamesTabScreen].
  const CPGamesTabScreen({super.key});

  void _onOpenGame(BuildContext context, CPGameViewModel game) {
    context.pushRoute(CPGameDetailScreen.pathForId(game.id), extra: game);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPGamesCubit, CPGamesState>(
      builder: (BuildContext context, CPGamesState state) {
        return ListView(
          cacheExtent: 600,
          padding: EdgeInsets.all(12.w),
          children: <Widget>[
            Text(context.l10n.gamesTab, style: CPAppTextStyles.h2),
            SizedBox(height: 10.h),
            if (state is CPGamesLoadingState)
              const CPAppLoadingSkeleton(height: 380)
            else if (state is CPGamesErrorState)
              CPAppErrorState(
                message: state.message,
                retryLabel: context.l10n.retry,
                onRetry: () =>
                    context.read<CPGamesCubit>().loadGames(context.l10n),
              )
            else
              CPGamesGrid(
                games: (state as CPGamesSuccessState).games,
                onOpenGame: (CPGameViewModel game) =>
                    _onOpenGame(context, game),
              ),
          ],
        );
      },
    );
  }
}
