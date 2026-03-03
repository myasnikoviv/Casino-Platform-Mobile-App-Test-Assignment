import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Home hero section with two promotional banners.
class CPPromoCarousel extends StatelessWidget {
  /// Creates [CPPromoCarousel].
  const CPPromoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.h,
      child: PageView(
        children: <Widget>[
          CPPromoBanner(
            imageUrl: 'https://picsum.photos/seed/promo1/1200/600',
            title: context.l10n.text('promoTitle1'),
            ctaLabel: context.l10n.text('promoCta'),
          ),
          CPPromoBanner(
            imageUrl: 'https://picsum.photos/seed/promo2/1200/600',
            title: context.l10n.text('promoTitle2'),
            ctaLabel: context.l10n.text('promoCta'),
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
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.r),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(imageUrl, fit: BoxFit.cover),
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
      ),
    );
  }
}
