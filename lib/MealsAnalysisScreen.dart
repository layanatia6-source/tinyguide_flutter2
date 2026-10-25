import 'package:flutter/material.dart';
import 'MealDistributionDetailsScreen.dart';

class MealsAnalysisScreen extends StatelessWidget {
  final String childName;
  final DateTime startDate;
  final DateTime endDate;

  const MealsAnalysisScreen({
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
                                  'تحليل الوجبات',
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
                                          color:
                                          textColor.withOpacity(0.12),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.arrow_back_ios_new_rounded,
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
                            'تقرير وجبات $childName',
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
                                        color: secondaryTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        Text(
                          'ملخص الوجبات',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // =========================
                        // Summary Cards
                        // =========================
                        LayoutBuilder(
                          builder: (context, innerConstraints) {
                            if (isVerySmall) {
                              return Column(
                                children: [
                                  _summaryCard(
                                    context,
                                    icon: Icons.restaurant_rounded,
                                    title: 'إجمالي الوجبات',
                                    value: '12',
                                  ),

                                  const SizedBox(height: 12),

                                  _summaryCard(
                                    context,
                                    icon: Icons.free_breakfast_rounded,
                                    title: 'وجبات الإفطار',
                                    value: '4',
                                  ),

                                  const SizedBox(height: 12),

                                  _summaryCard(
                                    context,
                                    icon: Icons.lunch_dining_rounded,
                                    title: 'وجبات رئيسية',
                                    value: '8',
                                  ),
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(
                                  child: _summaryCard(
                                    context,
                                    icon: Icons.restaurant_rounded,
                                    title: 'إجمالي الوجبات',
                                    value: '12',
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: _summaryCard(
                                    context,
                                    icon: Icons.free_breakfast_rounded,
                                    title: 'وجبات الإفطار',
                                    value: '4',
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: _summaryCard(
                                    context,
                                    icon: Icons.lunch_dining_rounded,
                                    title: 'وجبات رئيسية',
                                    value: '8',
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        // =========================
                        // Analysis Notes
                        // =========================
                        Text(
                          'ملاحظات التحليل',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 14),

                        _analysisItem(
                          context,
                          icon:
                          Icons.check_circle_outline_rounded,
                          title: 'انتظام التسجيل',
                          description:
                          'تم تسجيل الوجبات بصورة منتظمة خلال الفترة المحددة.',
                        ),

                        const SizedBox(height: 12),

                        _analysisItem(
                          context,
                          icon: Icons.access_time_rounded,
                          title: 'توزيع الوجبات',
                          description:
                          'عرض تفاصيل أوقات الوجبات المسجلة خلال الفترة المحددة.',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MealDistributionDetailsScreen(
                                      childName: childName,
                                      startDate: startDate,
                                      endDate: endDate,
                                    ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12),

                        _analysisItem(
                          context,
                          icon: Icons.info_outline_rounded,
                          title: 'تنبيه',
                          description:
                          'هذا التحليل تعليمي وتنظيمي فقط، ولا يقدم تشخيصًا طبيًا أو تعديلاً على العلاج.',
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
  // Analysis Item
  // =========================
  Widget _analysisItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        VoidCallback? onTap,
      }) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color textColor = theme.colorScheme.onSurface;

    final Widget card = Container(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 23,
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
                    color: textColor.withOpacity(0.60),
                  ),
                ),
              ],
            ),
          ),

          if (onTap != null) ...[
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: textColor.withOpacity(0.40),
            ),
          ],
        ],
      ),
    );

    if (onTap == null) {
      return card;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: card,
    );
  }
}