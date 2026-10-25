import 'package:flutter/material.dart';

class MedicationReportScreen extends StatelessWidget {
  final String childName;
  final DateTime startDate;
  final DateTime endDate;

  const MedicationReportScreen({
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

    final bool isDark =
        theme.brightness == Brightness.dark;

    final Color primaryColor =
        theme.primaryColor;

    final Color textColor = isDark
        ? Colors.white
        : const Color(0xff2C4A5A);

    final Color secondaryTextColor = isDark
        ? Colors.white.withOpacity(0.60)
        : const Color(0xff78909A);

    final Color cardColor = isDark
        ? const Color(0xff1D292D)
        : Colors.white;

    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.12)
        : const Color(0xffE2EEEE);

    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double width =
                  constraints.maxWidth;

              final bool isVerySmall =
                  width < 390;

              final bool isTablet =
                  width >= 600;

              final double horizontalPadding =
              isVerySmall
                  ? 14
                  : isTablet
                  ? 36
                  : 20;

              return SingleChildScrollView(
                physics:
                const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal:
                  horizontalPadding,
                  vertical: 18,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints:
                    const BoxConstraints(
                      maxWidth: 760,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        // =========================
                        // Header
                        // =========================
                        SizedBox(
                          height: 48,
                          child: Stack(
                            alignment:
                            Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'تقرير الأدوية',
                                  textAlign:
                                  TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                    isTablet
                                        ? 31
                                        : 27,
                                    fontWeight:
                                    FontWeight.bold,
                                    color:
                                    textColor,
                                  ),
                                ),
                              ),

                              // سهم رجوع بدون
                              // خلفية أو Border
                              Align(
                                alignment:
                                AlignmentDirectional
                                    .centerStart,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  padding:
                                  EdgeInsets.zero,
                                  constraints:
                                  const BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                  ),
                                  splashRadius: 22,
                                  icon: Icon(
                                    Icons
                                        .arrow_back_ios_new_rounded,
                                    color:
                                    textColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Padding(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 8,
                          ),
                          child: Text(
                            'متابعة الأدوية المسجلة لـ $childName',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              secondaryTextColor,
                              fontWeight:
                              FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        // =========================
                        // Period
                        // =========================
                        Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.all(
                            16,
                          ),
                          decoration:
                          BoxDecoration(
                            color: cardColor,
                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),
                            border: Border.all(
                              color: borderColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration:
                                BoxDecoration(
                                  color: primaryColor
                                      .withOpacity(
                                    isDark
                                        ? 0.14
                                        : 0.10,
                                  ),
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    14,
                                  ),
                                ),
                                child: Icon(
                                  Icons
                                      .date_range_rounded,
                                  color:
                                  primaryColor,
                                ),
                              ),

                              const SizedBox(
                                width: 12,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      'فترة التقرير',
                                      style:
                                      TextStyle(
                                        fontSize:
                                        15,
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        color:
                                        textColor,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 5,
                                    ),

                                    Text(
                                      '${formatDate(startDate)} - ${formatDate(endDate)}',
                                      style:
                                      TextStyle(
                                        fontSize:
                                        13,
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

                        const SizedBox(
                          height: 22,
                        ),

                        Text(
                          'ملخص الأدوية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(
                          height: 14,
                        ),

                        // =========================
                        // Summary
                        // =========================
                        LayoutBuilder(
                          builder: (
                              context,
                              innerConstraints,
                              ) {
                            if (isVerySmall) {
                              return Column(
                                children: [
                                  _summaryCard(
                                    context,
                                    icon: Icons
                                        .medication_rounded,
                                    title:
                                    'الأدوية المسجلة',
                                    value: '3',
                                  ),

                                  const SizedBox(
                                    height: 12,
                                  ),

                                  _summaryCard(
                                    context,
                                    icon: Icons
                                        .schedule_rounded,
                                    title:
                                    'الجرعات اليومية',
                                    value: '5',
                                  ),

                                  const SizedBox(
                                    height: 12,
                                  ),

                                  _summaryCard(
                                    context,
                                    icon: Icons
                                        .check_circle_outline_rounded,
                                    title:
                                    'الجرعات المسجلة',
                                    value: '14',
                                  ),
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(
                                  child:
                                  _summaryCard(
                                    context,
                                    icon: Icons
                                        .medication_rounded,
                                    title:
                                    'الأدوية المسجلة',
                                    value: '3',
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child:
                                  _summaryCard(
                                    context,
                                    icon: Icons
                                        .schedule_rounded,
                                    title:
                                    'الجرعات اليومية',
                                    value: '5',
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child:
                                  _summaryCard(
                                    context,
                                    icon: Icons
                                        .check_circle_outline_rounded,
                                    title:
                                    'الجرعات المسجلة',
                                    value: '14',
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        // =========================
                        // Medication Details
                        // =========================
                        Text(
                          'تفاصيل الأدوية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(
                          height: 14,
                        ),

                        _medicationItem(
                          context,
                          name: 'الدواء الأول',
                          dose: 'جرعة مسجلة',
                          schedule:
                          'حسب الجدول المسجل',
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        _medicationItem(
                          context,
                          name: 'الدواء الثاني',
                          dose: 'جرعة مسجلة',
                          schedule:
                          'حسب الجدول المسجل',
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        _medicationItem(
                          context,
                          name: 'الدواء الثالث',
                          dose: 'جرعة مسجلة',
                          schedule:
                          'حسب الجدول المسجل',
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        // =========================
                        // Educational Note
                        // =========================
                        Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.all(
                            14,
                          ),
                          decoration:
                          BoxDecoration(
                            color: primaryColor
                                .withOpacity(
                              isDark
                                  ? 0.10
                                  : 0.08,
                            ),
                            borderRadius:
                            BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Icon(
                                Icons
                                    .info_outline_rounded,
                                color:
                                primaryColor,
                                size: 22,
                              ),

                              const SizedBox(
                                width: 8,
                              ),

                              Expanded(
                                child: Text(
                                  'هذا التقرير يعرض الأدوية والجرعات المسجلة فقط، ولا يوصي بتغيير الجرعة أو إيقاف أو بدء أي علاج.',
                                  style:
                                  TextStyle(
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

                        const SizedBox(
                          height: 20,
                        ),
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
    final ThemeData theme =
    Theme.of(context);

    final bool isDark =
        theme.brightness == Brightness.dark;

    final Color primaryColor =
        theme.primaryColor;

    final Color textColor = isDark
        ? Colors.white
        : const Color(0xff2C4A5A);

    final Color secondaryTextColor = isDark
        ? Colors.white.withOpacity(0.60)
        : const Color(0xff78909A);

    final Color cardColor = isDark
        ? const Color(0xff1D292D)
        : Colors.white;

    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.12)
        : const Color(0xffE2EEEE);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
        BorderRadius.circular(17),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(
                isDark ? 0.14 : 0.10,
              ),
              borderRadius:
              BorderRadius.circular(13),
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
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // Medication Item
  // =========================
  Widget _medicationItem(
      BuildContext context, {
        required String name,
        required String dose,
        required String schedule,
      }) {
    final ThemeData theme =
    Theme.of(context);

    final bool isDark =
        theme.brightness == Brightness.dark;

    final Color primaryColor =
        theme.primaryColor;

    final Color textColor = isDark
        ? Colors.white
        : const Color(0xff2C4A5A);

    final Color secondaryTextColor = isDark
        ? Colors.white.withOpacity(0.60)
        : const Color(0xff78909A);

    final Color cardColor = isDark
        ? const Color(0xff1D292D)
        : Colors.white;

    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.12)
        : const Color(0xffE2EEEE);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
        BorderRadius.circular(17),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(
                isDark ? 0.14 : 0.10,
              ),
              borderRadius:
              BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.medication_outlined,
              color: primaryColor,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                    FontWeight.bold,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  dose,
                  style: TextStyle(
                    fontSize: 12.5,
                    color:
                    secondaryTextColor,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(
                      Icons
                          .access_time_rounded,
                      size: 16,
                      color: primaryColor,
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        schedule,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                          secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}