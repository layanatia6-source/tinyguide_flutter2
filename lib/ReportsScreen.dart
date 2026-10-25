import 'package:flutter/material.dart';
import 'ReportGenerationScreen.dart';

class ReportsScreen extends StatelessWidget {
  final String childName;
  final DateTime birthDate;
  final String gender;
  final String? childImagePath;

  const ReportsScreen({
    super.key,
    required this.childName,
    required this.birthDate,
    required this.gender,
    this.childImagePath,
  });

  int calculateAge(DateTime dateOfBirth) {
    final DateTime today = DateTime.now();

    int age = today.year - dateOfBirth.year;

    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month &&
            today.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color primaryColor = theme.primaryColor;

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

    final int childAge = calculateAge(birthDate);

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
                    constraints: const BoxConstraints(
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
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'التقارير',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                    isTablet ? 31 : 27,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),

                              // سهم الرجوع بدون خلفية أو Border
                              Align(
                                alignment: AlignmentDirectional
                                    .centerStart,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints:
                                  const BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                  ),
                                  splashRadius: 22,
                                  icon: Icon(
                                    Icons
                                        .arrow_back_ios_new_rounded,
                                    color: textColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Text(
                            'متابعة وتحليل بيانات $childName',
                            style: TextStyle(
                              fontSize: 14,
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // =========================
                        // Child Profile Card
                        // =========================
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(
                            isVerySmall ? 15 : 18,
                          ),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius:
                            BorderRadius.circular(22),
                            border: Border.all(
                              color: borderColor,
                            ),
                            boxShadow: isDark
                                ? []
                                : [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.04),
                                blurRadius: 12,
                                offset:
                                const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: isVerySmall
                              ? Column(
                            children: [
                              _buildChildAvatar(
                                primaryColor:
                                primaryColor,
                                size: 82,
                              ),

                              const SizedBox(
                                height: 14,
                              ),

                              Text(
                                childName,
                                textAlign:
                                TextAlign.center,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight:
                                  FontWeight.bold,
                                  color: textColor,
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Wrap(
                                alignment:
                                WrapAlignment.center,
                                spacing: 14,
                                runSpacing: 8,
                                children: [
                                  _childInfo(
                                    icon: Icons
                                        .calendar_month_outlined,
                                    text:
                                    '$childAge سنوات',
                                    primaryColor:
                                    primaryColor,
                                    textColor:
                                    textColor,
                                  ),
                                  _childInfo(
                                    icon: gender ==
                                        'بنت'
                                        ? Icons.female
                                        : Icons.male,
                                    text: gender,
                                    primaryColor:
                                    primaryColor,
                                    textColor:
                                    textColor,
                                  ),
                                ],
                              ),
                            ],
                          )
                              : Row(
                            children: [
                              _buildChildAvatar(
                                primaryColor:
                                primaryColor,
                                size: isTablet
                                    ? 95
                                    : 86,
                              ),

                              const SizedBox(
                                width: 16,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      childName,
                                      style:
                                      TextStyle(
                                        fontSize:
                                        isTablet
                                            ? 24
                                            : 21,
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        color:
                                        textColor,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Wrap(
                                      spacing: 14,
                                      runSpacing: 8,
                                      children: [
                                        _childInfo(
                                          icon: Icons
                                              .calendar_month_outlined,
                                          text:
                                          '$childAge سنوات',
                                          primaryColor:
                                          primaryColor,
                                          textColor:
                                          textColor,
                                        ),
                                        _childInfo(
                                          icon: gender ==
                                              'بنت'
                                              ? Icons
                                              .female
                                              : Icons
                                              .male,
                                          text:
                                          gender,
                                          primaryColor:
                                          primaryColor,
                                          textColor:
                                          textColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // =========================
                        // Overview
                        // =========================
                        Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius:
                            BorderRadius.circular(20),
                            border: Border.all(
                              color: borderColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: primaryColor
                                      .withOpacity(0.12),
                                  borderRadius:
                                  BorderRadius.circular(
                                    16,
                                  ),
                                ),
                                child: Icon(
                                  Icons.bar_chart_rounded,
                                  color: primaryColor,
                                  size: 32,
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'نظرة عامة على التقارير',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),

                                    const SizedBox(height: 7),

                                    Text(
                                      'يمكنك إنشاء ومراجعة تقارير الصحة والمتابعة للطفل.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.6,
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

                        const SizedBox(height: 32),

                        // =========================
                        // Generate Report Button
                        // =========================
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ReportGenerationScreen(
                                        childName: childName,
                                      ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add_chart_rounded,
                            ),
                            label: const Text(
                              'إنشاء تقرير',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 36),

                        // =========================
                        // Small Note
                        // =========================
                        Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: primaryColor
                                .withOpacity(
                              isDark ? 0.10 : 0.08,
                            ),
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: primaryColor,
                                size: 20,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  'اختاري نوع التقرير والفترة المناسبة من صفحة إنشاء التقرير.',
                                  textAlign:
                                  TextAlign.start,
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

                        const SizedBox(height: 28),
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
  // Child Avatar
  // =========================
  Widget _buildChildAvatar({
    required Color primaryColor,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: primaryColor.withOpacity(0.35),
          width: 2,
        ),
      ),
      child: childImagePath == null
          ? Icon(
        gender == 'بنت'
            ? Icons.face_3_rounded
            : Icons.face_6_rounded,
        size: size * 0.58,
        color: primaryColor,
      )
          : ClipOval(
        child: Image.asset(
          childImagePath!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // =========================
  // Child Info
  // =========================
  Widget _childInfo({
    required IconData icon,
    required String text,
    required Color primaryColor,
    required Color textColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: primaryColor,
        ),

        const SizedBox(width: 5),

        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: textColor.withOpacity(0.65),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}