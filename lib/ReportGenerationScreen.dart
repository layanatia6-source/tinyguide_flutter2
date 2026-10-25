import 'package:flutter/material.dart';
import 'MealsAnalysisScreen.dart';
import 'MedicationReportScreen.dart';
import 'GrowthReportScreen.dart';
import 'ActivityReportScreen.dart';
import 'HealthAdviceReportScreen.dart';

class ReportGenerationScreen extends StatefulWidget {
  final String childName;

  const ReportGenerationScreen({
    super.key,
    required this.childName,
  });

  @override
  State<ReportGenerationScreen> createState() =>
      _ReportGenerationScreenState();
}

class _ReportGenerationScreenState extends State<ReportGenerationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedReportType;
  DateTime? startDate;
  DateTime? endDate;

  bool isGenerating = false;

  String? reportTypeError;
  String? startDateError;
  String? endDateError;

  final List<String> reportTypes = const [
    'تحليل الوجبات',
    'تقرير الأدوية',
    'تقرير النمو',
    'تقرير النشاط',
    'النصائح الصحية',
  ];

  String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }

    final String day =
    date.day.toString().padLeft(2, '0');

    final String month =
    date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  // =========================
  // Start Date
  // =========================
  Future<void> selectStartDate() async {
    final DateTime now = DateTime.now();

    final DateTime? selectedDate =
    await showDatePicker(
      context: context,
      initialDate: startDate ?? now,
      firstDate: DateTime(2020),
      lastDate: now,
      helpText: 'اختر تاريخ البداية',
      cancelText: 'إلغاء',
      confirmText: 'اختيار',
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      startDate = selectedDate;
      startDateError = null;

      if (endDate != null &&
          endDate!.isBefore(selectedDate)) {
        endDate = null;
        endDateError =
        'اختاري تاريخ النهاية من جديد';
      }
    });
  }

  // =========================
  // End Date
  // =========================
  Future<void> selectEndDate() async {
    if (startDate == null) {
      setState(() {
        startDateError =
        'اختاري تاريخ البداية أولاً';
      });

      return;
    }

    final DateTime now = DateTime.now();

    final DateTime? selectedDate =
    await showDatePicker(
      context: context,
      initialDate: endDate ?? now,
      firstDate: startDate!,
      lastDate: now,
      helpText: 'اختر تاريخ النهاية',
      cancelText: 'إلغاء',
      confirmText: 'اختيار',
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      endDate = selectedDate;
      endDateError = null;
    });
  }

  // =========================
  // Temporary Message
  // =========================
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // =========================
  // Generate Report
  // =========================
  Future<void> generateReport() async {
    FocusScope.of(context).unfocus();

    bool hasError = false;

    setState(() {
      reportTypeError = null;
      startDateError = null;
      endDateError = null;

      if (selectedReportType == null) {
        reportTypeError =
        'يجب اختيار نوع التقرير';
        hasError = true;
      }

      if (startDate == null) {
        startDateError =
        'يجب اختيار تاريخ البداية';
        hasError = true;
      }

      if (endDate == null) {
        endDateError =
        'يجب اختيار تاريخ النهاية';
        hasError = true;
      }

      if (startDate != null &&
          endDate != null &&
          endDate!.isBefore(startDate!)) {
        endDateError =
        'تاريخ النهاية يجب أن يكون بعد تاريخ البداية';
        hasError = true;
      }
    });

    if (hasError) {
      return;
    }

    setState(() {
      isGenerating = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      isGenerating = false;
    });

    // =========================
    // Meals
    // =========================
    if (selectedReportType ==
        'تحليل الوجبات') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MealsAnalysisScreen(
                childName: widget.childName,
                startDate: startDate!,
                endDate: endDate!,
              ),
        ),
      );

      return;
    }

    // =========================
    // Medication
    // =========================
    if (selectedReportType ==
        'تقرير الأدوية') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MedicationReportScreen(
                childName: widget.childName,
                startDate: startDate!,
                endDate: endDate!,
              ),
        ),
      );

      return;
    }

    // =========================
    // Growth
    // =========================
    if (selectedReportType ==
        'تقرير النمو') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GrowthReportScreen(
                childName: widget.childName,
                startDate: startDate!,
                endDate: endDate!,
              ),
        ),
      );

      return;
    }

    // =========================
    // Activity
    // =========================
    if (selectedReportType ==
        'تقرير النشاط') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ActivityReportScreen(
                childName: widget.childName,
                startDate: startDate!,
                endDate: endDate!,
              ),
        ),
      );

      return;
    }

    // =========================
    // Health Advice
    // =========================
    if (selectedReportType ==
        'النصائح الصحية') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HealthAdviceReportScreen(
                childName: widget.childName,
                startDate: startDate!,
                endDate: endDate!,
              ),
        ),
      );

      return;
    }

    _showMessage(
      'سيتم ربط هذا التقرير في الخطوات التالية',
    );
  }

  @override
  Widget build(BuildContext context) {
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

    final Color fieldColor = isDark
        ? const Color(0xff1D292D)
        : Colors.white;

    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.12)
        : const Color(0xffD7E7E7);

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
                      maxWidth: 700,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
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
                                    'إنشاء تقرير',
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

                                // سهم الرجوع بدون
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
                              'اختاري نوع التقرير والفترة الخاصة بـ ${widget.childName}',
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
                            height: 28,
                          ),

                          // =========================
                          // Report Type
                          // =========================
                          Container(
                            width:
                            double.infinity,
                            padding:
                            const EdgeInsets
                                .all(18),
                            decoration:
                            BoxDecoration(
                              color: cardColor,
                              borderRadius:
                              BorderRadius
                                  .circular(20),
                              border:
                              Border.all(
                                color:
                                borderColor,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  'نوع التقرير',
                                  style:
                                  TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    color:
                                    textColor,
                                  ),
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                DropdownButtonFormField<
                                    String>(
                                  value:
                                  selectedReportType,
                                  isExpanded: true,
                                  dropdownColor:
                                  cardColor,
                                  iconEnabledColor:
                                  textColor,
                                  style:
                                  TextStyle(
                                    color:
                                    textColor,
                                    fontSize: 14,
                                  ),
                                  hint: Text(
                                    'اختاري نوع التقرير',
                                    style:
                                    TextStyle(
                                      color:
                                      secondaryTextColor,
                                      fontSize:
                                      14,
                                    ),
                                  ),
                                  items: reportTypes
                                      .map(
                                        (type) =>
                                        DropdownMenuItem<
                                            String>(
                                          value:
                                          type,
                                          child:
                                          Text(
                                            type,
                                            style:
                                            TextStyle(
                                              color:
                                              textColor,
                                            ),
                                          ),
                                        ),
                                  )
                                      .toList(),
                                  onChanged:
                                      (value) {
                                    setState(() {
                                      selectedReportType =
                                          value;

                                      reportTypeError =
                                      null;
                                    });
                                  },
                                  decoration:
                                  _inputDecoration(
                                    context,
                                    icon: Icons
                                        .description_outlined,
                                    errorText:
                                    reportTypeError,
                                    fieldColor:
                                    fieldColor,
                                    borderColor:
                                    borderColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          // =========================
                          // Period
                          // =========================
                          Container(
                            width:
                            double.infinity,
                            padding:
                            const EdgeInsets
                                .all(18),
                            decoration:
                            BoxDecoration(
                              color: cardColor,
                              borderRadius:
                              BorderRadius
                                  .circular(20),
                              border:
                              Border.all(
                                color:
                                borderColor,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  'الفترة',
                                  style:
                                  TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    color:
                                    textColor,
                                  ),
                                ),

                                const SizedBox(
                                  height: 14,
                                ),

                                // =========================
                                // Start Date
                                // =========================
                                InkWell(
                                  onTap:
                                  selectStartDate,
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    14,
                                  ),
                                  child:
                                  InputDecorator(
                                    decoration:
                                    _inputDecoration(
                                      context,
                                      icon: Icons
                                          .calendar_month_outlined,
                                      errorText:
                                      startDateError,
                                      fieldColor:
                                      fieldColor,
                                      borderColor:
                                      borderColor,
                                    ),
                                    child: Text(
                                      startDate ==
                                          null
                                          ? 'من تاريخ'
                                          : formatDate(
                                        startDate,
                                      ),
                                      style:
                                      TextStyle(
                                        fontSize:
                                        14,
                                        color: startDate ==
                                            null
                                            ? secondaryTextColor
                                            : textColor,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                // =========================
                                // End Date
                                // =========================
                                InkWell(
                                  onTap:
                                  selectEndDate,
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    14,
                                  ),
                                  child:
                                  InputDecorator(
                                    decoration:
                                    _inputDecoration(
                                      context,
                                      icon: Icons
                                          .event_available_outlined,
                                      errorText:
                                      endDateError,
                                      fieldColor:
                                      fieldColor,
                                      borderColor:
                                      borderColor,
                                    ),
                                    child: Text(
                                      endDate ==
                                          null
                                          ? 'إلى تاريخ'
                                          : formatDate(
                                        endDate,
                                      ),
                                      style:
                                      TextStyle(
                                        fontSize:
                                        14,
                                        color: endDate ==
                                            null
                                            ? secondaryTextColor
                                            : textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          // =========================
                          // Info
                          // =========================
                          Container(
                            width:
                            double.infinity,
                            padding:
                            const EdgeInsets
                                .all(13),
                            decoration:
                            BoxDecoration(
                              color: primaryColor
                                  .withOpacity(
                                isDark
                                    ? 0.10
                                    : 0.08,
                              ),
                              borderRadius:
                              BorderRadius
                                  .circular(14),
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
                                  size: 21,
                                ),

                                const SizedBox(
                                  width: 8,
                                ),

                                Expanded(
                                  child: Text(
                                    'تأكدي من نوع التقرير والفترة قبل إنشاء التقرير.',
                                    style:
                                    TextStyle(
                                      fontSize:
                                      12,
                                      height: 1.5,
                                      color:
                                      secondaryTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          // =========================
                          // Generate Button
                          // =========================
                          SizedBox(
                            width:
                            double.infinity,
                            height: 56,
                            child:
                            ElevatedButton
                                .icon(
                              onPressed:
                              isGenerating
                                  ? null
                                  : generateReport,
                              icon: isGenerating
                                  ? const SizedBox
                                  .shrink()
                                  : const Icon(
                                Icons
                                    .bar_chart_rounded,
                              ),
                              label: isGenerating
                                  ? const SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                CircularProgressIndicator(
                                  color:
                                  Colors.white,
                                  strokeWidth:
                                  2.5,
                                ),
                              )
                                  : const Text(
                                'إنشاء التقرير',
                                style:
                                TextStyle(
                                  fontSize:
                                  16,
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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
  // Input Decoration
  // =========================
  InputDecoration _inputDecoration(
      BuildContext context, {
        required IconData icon,
        required Color fieldColor,
        required Color borderColor,
        String? errorText,
      }) {
    final ThemeData theme =
    Theme.of(context);

    final Color primaryColor =
        theme.primaryColor;

    final Color textColor =
        theme.colorScheme.onSurface;

    final bool isDark =
        theme.brightness == Brightness.dark;

    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: primaryColor,
      ),

      filled: true,
      fillColor: fieldColor,

      errorText: errorText,

      errorStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),

      hintStyle: TextStyle(
        color: isDark
            ? Colors.white.withOpacity(0.55)
            : const Color(0xff8A989D),
      ),

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),

      enabledBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide: BorderSide(
          color: borderColor,
          width: 1.2,
        ),
      ),

      focusedBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide: BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),

      errorBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide:
        const BorderSide(
          color: Colors.red,
          width: 1.2,
        ),
      ),

      focusedErrorBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide:
        const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),

      disabledBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide: BorderSide(
          color: textColor.withOpacity(0.10),
        ),
      ),
    );
  }
}