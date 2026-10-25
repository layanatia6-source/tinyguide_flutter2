import 'package:flutter/material.dart';

class ActivityReportScreen extends StatelessWidget {
  final String childName;
  final DateTime startDate;
  final DateTime endDate;

  const ActivityReportScreen({
    super.key,
    required this.childName,
    required this.startDate,
    required this.endDate,
  });

  String formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color textColor = theme.colorScheme.onSurface;
    final Color secondaryTextColor = textColor.withOpacity(0.60);

    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              final bool isVerySmall = width < 390;
              final bool isTablet = width >= 600;

              final double horizontalPadding = isVerySmall
                  ? 14
                  : isTablet
                  ? 36
                  : 20;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 18,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =========================
                        // Header
                        // =========================
                        SizedBox(
                          height: 48,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'تقرير النشاط',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: isTablet ? 31 : 27,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),

                              Align(
                                alignment:
                                AlignmentDirectional.centerStart,
                                child: Material(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    child: Container(
                                      width: 44,
                                      height: 44,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        border: Border.all(
                                          color: textColor
                                              .withOpacity(0.12),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons
                                            .arrow_back_ios_new_rounded,
                                        size: 19,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'متابعة نشاط $childName خلال الفترة المحددة',
                            style: TextStyle(
                              fontSize: 14,
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // =========================
                        // Period
                        // =========================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: textColor.withOpacity(0.10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color:
                                  primaryColor.withOpacity(0.10),
                                  borderRadius:
                                  BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.date_range_rounded,
                                  color: primaryColor,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'فترة التقرير',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      '${formatDate(startDate)} - ${formatDate(endDate)}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color:
                                        secondaryTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          'ملخص النشاط',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // =========================
                        // Summary
                        // =========================
                        if (isVerySmall)
                          Column(
                            children: [
                              _summaryCard(
                                context,
                                icon:
                                Icons.directions_run_rounded,
                                title: 'عدد الأنشطة',
                                value: '8',
                              ),

                              const SizedBox(height: 12),

                              _summaryCard(
                                context,
                                icon: Icons.timer_outlined,
                                title: 'إجمالي المدة',
                                value: '240 دقيقة',
                              ),

                              const SizedBox(height: 12),

                              _summaryCard(
                                context,
                                icon: Icons
                                    .calendar_today_outlined,
                                title: 'أيام النشاط',
                                value: '5 أيام',
                              ),
                            ],
                          )
                        else
                          Row(
                            children: [
                              Expanded(
                                child: _summaryCard(
                                  context,
                                  icon: Icons
                                      .directions_run_rounded,
                                  title: 'عدد الأنشطة',
                                  value: '8',
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: _summaryCard(
                                  context,
                                  icon:
                                  Icons.timer_outlined,
                                  title: 'إجمالي المدة',
                                  value: '240 دقيقة',
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: _summaryCard(
                                  context,
                                  icon: Icons
                                      .calendar_today_outlined,
                                  title: 'أيام النشاط',
                                  value: '5 أيام',
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 24),

                        // =========================
                        // Activity Details
                        // =========================
                        Text(
                          'تفاصيل النشاط',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 14),

                        _activityItem(
                          context,
                          icon: Icons.directions_walk_rounded,
                          title: 'المشي',
                          description:
                          'تم تسجيل نشاط المشي ضمن الفترة المحددة.',
                        ),

                        const SizedBox(height: 12),

                        _activityItem(
                          context,
                          icon: Icons.directions_run_rounded,
                          title: 'الجري',
                          description:
                          'تم تسجيل نشاط الجري ضمن الفترة المحددة.',
                        ),

                        const SizedBox(height: 12),

                        _activityItem(
                          context,
                          icon: Icons.sports_soccer_rounded,
                          title: 'نشاط رياضي',
                          description:
                          'يمكن عرض الأنشطة الرياضية المسجلة للطفل هنا.',
                        ),

                        const SizedBox(height: 24),

                        // =========================
                        // Educational Note
                        // =========================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color:
                            primaryColor.withOpacity(0.08),
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: primaryColor,
                                size: 22,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  'هذا التقرير مخصص للمتابعة والتنظيم فقط، ولا يعتبر تقييمًا طبيًا لمستوى نشاط الطفل.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.6,
                                    color:
                                    secondaryTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =========================
  // Summary Card
  // =========================
  Widget _summaryCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String value,
      }) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color textColor = theme.colorScheme.onSurface;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: textColor.withOpacity(0.10),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: textColor.withOpacity(0.60),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // Activity Item
  // =========================
  Widget _activityItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
      }) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color textColor = theme.colorScheme.onSurface;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: textColor.withOpacity(0.10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.6,
                    color:
                    textColor.withOpacity(0.60),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}