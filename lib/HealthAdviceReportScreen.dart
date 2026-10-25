import 'package:flutter/material.dart';
import 'AdviceDetailsScreen.dart';

class HealthAdviceReportScreen extends StatelessWidget {
  final String childName;
  final DateTime startDate;
  final DateTime endDate;

  const HealthAdviceReportScreen({
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
                                  'النصائح الصحية',
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
                            'نصائح تعليمية مرتبطة بمتابعة $childName',
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
                                        fontWeight: FontWeight.bold,
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

                        const SizedBox(height: 24),

                        // =========================
                        // Advice
                        // =========================
                        Text(
                          'نصائح المتابعة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 14),

                        _adviceCard(
                          context,
                          icon: Icons.restaurant_menu_rounded,
                          title: 'تنظيم الوجبات',
                          description:
                          'يساعد تسجيل الوجبات بانتظام في تكوين سجل أوضح لعادات الطفل الغذائية.',
                        ),

                        const SizedBox(height: 12),

                        _adviceCard(
                          context,
                          icon: Icons.directions_run_rounded,
                          title: 'النشاط اليومي',
                          description:
                          'يمكن متابعة أوقات النشاط ومدته لملاحظة انتظام الروتين اليومي.',
                        ),

                        const SizedBox(height: 12),

                        _adviceCard(
                          context,
                          icon: Icons.monitor_weight_outlined,
                          title: 'متابعة النمو',
                          description:
                          'يساعد تسجيل الطول والوزن بشكل منتظم في الاحتفاظ بسجل نمو منظم.',
                        ),

                        const SizedBox(height: 12),

                        _adviceCard(
                          context,
                          icon: Icons.medication_outlined,
                          title: 'تسجيل الأدوية',
                          description:
                          'احرصي على تسجيل الأدوية ومواعيدها كما تم وصفها من المختص.',
                        ),

                        const SizedBox(height: 12),

                        _adviceCard(
                          context,
                          icon: Icons.event_available_outlined,
                          title: 'المواعيد والمتابعة',
                          description:
                          'الاحتفاظ بالمواعيد والفحوصات المسجلة يساعد في تنظيم المتابعة الصحية.',
                        ),

                        const SizedBox(height: 24),

                        // =========================
                        // Important Warning
                        // =========================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
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
                                Icons.health_and_safety_outlined,
                                color: primaryColor,
                                size: 23,
                              ),

                              const SizedBox(width: 9),

                              Expanded(
                                child: Text(
                                  'هذه النصائح للتوعية والتنظيم فقط. لا تعتبر تشخيصًا طبيًا ولا توصي بتغيير جرعة أو دواء أو خطة علاج. أي قرار علاجي يجب الرجوع فيه للطبيب أو المختص.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.7,
                                    color: secondaryTextColor,
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
  // Advice Card
  // =========================
  Widget _adviceCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
      }) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color textColor = theme.colorScheme.onSurface;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdviceDetailsScreen(
              title: title,
              description: description,
              icon: icon,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(17),
      child: Container(
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
            // الأيقونة - جهة اليمين
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

            // النص
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

            const SizedBox(width: 10),

            // السهم - يسار وفي منتصف الكارد
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: textColor.withOpacity(0.40),
            ),
          ],
        ),
      ),
    );
  }
}