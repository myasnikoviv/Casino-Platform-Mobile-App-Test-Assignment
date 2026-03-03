import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/ui/components/games_grid_skeleton.dart';
import 'package:casino_platform_test/src/features/games/ui/components/games_grid.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Games tab view.
class CPGamesTabView extends StatelessWidget {
  /// Creates [CPGamesTabView].
  const CPGamesTabView({required this.onOpenGame, super.key});

  final ValueChanged<CPGameViewModel> onOpenGame;

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
            switch (state) {
              CPGamesLoadingState() => const CPGamesGridSkeleton(),
              CPGamesErrorState(:final message) => CPAppErrorState(
                  message: message,
                  retryLabel: context.l10n.retry,
                  onRetry: () =>
                      context.read<CPGamesCubit>().loadGames(context.l10n),
                ),
              CPGamesSuccessState(:final games) => CPGamesGrid(
                  games: games,
                  onOpenGame: onOpenGame,
                ),
            },
          ],
        );
      },
    );
  }
}
