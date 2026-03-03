import 'dart:math';

import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/domain/entities/game_view_model.dart';
import 'package:casino_platform_test/src/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Game grid card with a short 3D flip animation on tap.
class GameCard extends StatefulWidget {
  /// Creates [GameCard].
  const GameCard({
    required this.game,
    required this.onOpen,
    super.key,
  });

  /// Rendered game view model.
  final GameViewModel game;

  /// Callback triggered after flip animation.
  final VoidCallback onOpen;

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    await _controller.forward();
    if (!mounted) {
      return;
    }
    widget.onOpen();
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final double angle = _controller.value * pi;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: child,
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: 'game-image-${widget.game.id}',
                  child: Image.network(
                    widget.game.thumbnailUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.game.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.label,
                    ),
                    SizedBox(height: 3.h),
                    AppBadge(label: widget.game.categoryLabel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
