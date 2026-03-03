import 'dart:async';

import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:casino_platform_test/src/shared/ui/app_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Home hero section with two promotional banners.
class CPPromoCarousel extends StatefulWidget {
  /// Creates [CPPromoCarousel].
  const CPPromoCarousel({super.key});

  @override
  State<CPPromoCarousel> createState() => _CPPromoCarouselState();
}

class _CPPromoCarouselState extends State<CPPromoCarousel> {
  static const Duration _autoScrollInterval = Duration(seconds: 4);

  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _autoScrollTimer = Timer.periodic(_autoScrollInterval, (_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }
      final int nextIndex = (_currentIndex + 1) % 2;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<_CPPromoContent> banners = <_CPPromoContent>[
      _CPPromoContent(
        imageUrl: 'https://picsum.photos/seed/promo1/1200/600',
        title: context.l10n.promoTitle1,
        ctaLabel: context.l10n.promoCta,
      ),
      _CPPromoContent(
        imageUrl: 'https://picsum.photos/seed/promo2/1200/600',
        title: context.l10n.promoTitle2,
        ctaLabel: context.l10n.promoCta,
      ),
    ];

    return SizedBox(
      height: 190.h,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              final _CPPromoContent banner = banners[index];
              return CPPromoBanner(
                imageUrl: banner.imageUrl,
                title: banner.title,
                ctaLabel: banner.ctaLabel,
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10.h,
            child: Center(
              child: IgnorePointer(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.32),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: _CPPromoPageIndicator(
                    count: banners.length,
                    currentIndex: _currentIndex,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Single promo banner used inside hero carousel.
class CPPromoBanner extends StatelessWidget {
  /// Creates [CPPromoBanner].
  const CPPromoBanner({
    required this.imageUrl,
    required this.title,
    required this.ctaLabel,
    super.key,
  });

  /// Banner background image URL.
  final String imageUrl;

  /// Banner title.
  final String title;

  /// CTA button label.
  final String ctaLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CPAppCachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[Color(0xA0000000), Color(0x20000000)],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  title,
                  style: CPAppTextStyles.h2.copyWith(color: Colors.white),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: 140.w,
                  child: CPAppButton(label: ctaLabel, onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CPPromoPageIndicator extends StatelessWidget {
  const _CPPromoPageIndicator({
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        count,
        (int index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          width: index == currentIndex ? 18.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: index == currentIndex
                ? const Color(0xFF0F766E)
                : const Color(0xFFCBD5E1),
            borderRadius: BorderRadius.circular(999.r),
          ),
        ),
      ),
    );
  }
}

class _CPPromoContent {
  const _CPPromoContent({
    required this.imageUrl,
    required this.title,
    required this.ctaLabel,
  });

  final String imageUrl;
  final String title;
  final String ctaLabel;
}
