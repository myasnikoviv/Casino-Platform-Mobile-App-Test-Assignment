import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Compact game metrics block for provider, RTP and volatility values.
class CPGameDetailMetrics extends StatelessWidget {
  /// Creates [CPGameDetailMetrics].
  const CPGameDetailMetrics({
    required this.provider,
    required this.rtp,
    required this.volatility,
    super.key,
  });

  /// Provider label value.
  final String provider;

  /// RTP label value.
  final String rtp;

  /// Volatility label value.
  final String volatility;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CPMetricRow(title: context.l10n.provider, value: provider),
        SizedBox(height: 8.h),
        CPMetricRow(title: context.l10n.rtp, value: rtp),
        SizedBox(height: 8.h),
        CPMetricRow(title: context.l10n.volatility, value: volatility),
      ],
    );
  }
}

/// Single metric row item.
class CPMetricRow extends StatelessWidget {
  /// Creates [CPMetricRow].
  const CPMetricRow({
    required this.title,
    required this.value,
    super.key,
  });

  /// Label text.
  final String title;

  /// Value text.
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(title, style: CPAppTextStyles.label)),
        Text(value, style: CPAppTextStyles.body),
      ],
    );
  }
}
