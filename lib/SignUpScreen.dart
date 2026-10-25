import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LoginScreen.dart';
import 'ChildInfoScreen.dart';
import 'validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController =
  TextEditingController();
  final TextEditingController secondNameController =
  TextEditingController();
  final TextEditingController lastNameController =
  TextEditingController();
  final TextEditingController usernameController =
  TextEditingController();
  final TextEditingController phoneController =
  TextEditingController();
  final TextEditingController passwordController =
  TextEditingController();

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode secondNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool obscurePassword = true;
  bool isPasswordFocused = false;
  bool isLoading = false;

  String selectedFlag = '';
  String selectedCountry = '';

  final Map<String, Map<String, String>> supportedCountries = {
    '967': {'flag': '🇾🇪', 'name': 'اليمن'},
    '966': {'flag': '🇸🇦', 'name': 'السعودية'},
    '971': {'flag': '🇦🇪', 'name': 'الإمارات'},
    '968': {'flag': '🇴🇲', 'name': 'عُمان'},
    '965': {'flag': '🇰🇼', 'name': 'الكويت'},
    '974': {'flag': '🇶🇦', 'name': 'قطر'},
    '973': {'flag': '🇧🇭', 'name': 'البحرين'},
  };

  @override
  void initState() {
    super.initState();

    passwordFocusNode.addListener(() {
      if (!mounted) return;

      setState(() {
        isPasswordFocused = passwordFocusNode.hasFocus;
      });
    });
  }

  void detectCountry(String value) {
    final String phone = Validators.cleanPhoneNumber(value);

    String flag = '';
    String country = '';

    for (final entry in supportedCountries.entries) {
      if (phone.startsWith(entry.key)) {
        flag = entry.value['flag'] ?? '';
        country = entry.value['name'] ?? '';
        break;
      }
    }

    setState(() {
      selectedFlag = flag;
      selectedCountry = country;
    });
  }

  Future<void> createAccount() async {
    FocusScope.of(context).unfocus();

    final bool isValid =
        formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final String cleanPhone =
    Validators.cleanPhoneNumber(phoneController.text);

    final String firstName =
    firstNameController.text.trim();
    final String username =
    usernameController.text.trim();
    final String secondName =
    secondNameController.text.trim();
    final String lastName =
    lastNameController.text.trim();

    setState(() {
      isLoading = true;
    });

    /*
      سيتم ربط إنشاء الحساب بقاعدة بيانات Laravel لاحقًا.

      POST /api/register

      البيانات:
      first_name
      middle_name
      last_name
      username
      phone
      password

      Laravel سيتحقق من البيانات، ويتأكد من عدم تكرار
      رقم الهاتف، ويشفّر كلمة المرور، ثم ينشئ الحساب.
    */

    debugPrint('First name: $firstName');
    debugPrint('Username entered: ${username.isNotEmpty}');
    debugPrint('Second name: $secondName');
    debugPrint('Last name: $lastName');
    debugPrint('Phone: $cleanPhone');

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم إنشاء الحساب بنجاح',
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ChildInfoScreen(),
      ),
    );
  }

  void goToLogin() {
    FocusScope.of(context).unfocus();

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();

    firstNameFocusNode.dispose();
    secondNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor =
        Theme.of(context).primaryColor;

    const Color darkColor = Color(0xff2C4A5A);
    const Color borderColor = Color(0xffD7E7E7);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            final double screenHeight = constraints.maxHeight;

            final bool isSmallScreen =
                screenWidth < 360 || screenHeight < 650;

            final bool isTablet = screenWidth >= 600;

            final double horizontalPadding = isSmallScreen
                ? 16
                : isTablet
                ? 40
                : 22;

            final double imageHeight = isSmallScreen
                ? 125
                : isTablet
                ? 190
                : 160;

            final double titleSize = isSmallScreen
                ? 24
                : isTablet
                ? 32
                : 28;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isSmallScreen ? 10 : 14,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 460,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          // Image
                          Image.asset(
                            'images/loginpic.jpg',
                            width: double.infinity,
                            height: imageHeight,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(
                            height: isSmallScreen ? 8 : 14,
                          ),

                          // Title
                          Text(
                            'إنشاء حساب جديد',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                              color: darkColor,
                            ),
                          ),

                          // Names
                          SizedBox(
                            height: isSmallScreen ? 18 : 25,
                          ),

                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller:
                                  firstNameController,
                                  focusNode: firstNameFocusNode,
                                  textAlign: TextAlign.center,
                                  keyboardType:
                                  TextInputType.name,
                                  textInputAction:
                                  TextInputAction.next,
                                  autovalidateMode:
                                  AutovalidateMode
                                      .onUserInteraction,
                                  validator:
                                  Validators.arabicName,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(
                                      secondNameFocusNode,
                                    );
                                  },
                                  decoration:
                                  nameInputDecoration(
                                    hint: 'الاسم الأول',
                                    primaryColor: primaryColor,
                                    borderColor: borderColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: TextFormField(
                                  controller:
                                  secondNameController,
                                  focusNode:
                                  secondNameFocusNode,
                                  textAlign: TextAlign.center,
                                  keyboardType:
                                  TextInputType.name,
                                  textInputAction:
                                  TextInputAction.next,
                                  autovalidateMode:
                                  AutovalidateMode
                                      .onUserInteraction,
                                  validator:
                                  Validators.arabicName,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(
                                      lastNameFocusNode,
                                    );
                                  },
                                  decoration:
                                  nameInputDecoration(
                                    hint: 'الاسم الثاني',
                                    primaryColor: primaryColor,
                                    borderColor: borderColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: TextFormField(
                                  controller:
                                  lastNameController,
                                  focusNode: lastNameFocusNode,
                                  textAlign: TextAlign.center,
                                  keyboardType:
                                  TextInputType.name,
                                  textInputAction:
                                  TextInputAction.next,
                                  autovalidateMode:
                                  AutovalidateMode
                                      .onUserInteraction,
                                  validator:
                                  Validators.arabicName,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(
                                      phoneFocusNode,
                                    );
                                  },
                                  decoration:
                                  nameInputDecoration(
                                    hint: 'اللقب',
                                    primaryColor: primaryColor,
                                    borderColor: borderColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Username


                          const SizedBox(height: 16),

                          // Phone
                          TextFormField(
                            controller: phoneController,
                            focusNode: phoneFocusNode,
                            keyboardType: TextInputType.phone,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            textInputAction:
                            TextInputAction.next,
                            validator:
                            Validators.supportedPhone,
                            autovalidateMode:
                            AutovalidateMode
                                .onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9+\-\s]'),
                              ),
                              LengthLimitingTextInputFormatter(16),
                            ],
                            onChanged: detectCountry,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(
                                passwordFocusNode,
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'رقم الهاتف',
                              hintTextDirection:
                              TextDirection.rtl,
                              hintStyle: const TextStyle(
                                color: Color(0xff9AA7AB),
                                fontSize: 16,
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                color: primaryColor,
                              ),
                              suffixIcon: selectedFlag.isEmpty
                                  ? const Padding(
                                padding:
                                EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                child: Icon(
                                  Icons.flag_outlined,
                                  color: Color(0xff9AA7AB),
                                ),
                              )
                                  : Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Center(
                                  widthFactor: 1,
                                  child: Text(
                                    selectedFlag,
                                    style: const TextStyle(
                                      fontSize: 27,
                                    ),
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: borderColor,
                                  width: 1.3,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.3,
                                ),
                              ),
                              focusedErrorBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          if (selectedCountry.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 6,
                                right: 8,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'الدولة: $selectedCountry',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                          const SizedBox(height: 16),

                          // Password
                          TextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            obscureText: obscurePassword,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            textInputAction:
                            TextInputAction.done,
                            maxLength: 6,
                            validator:
                            Validators.sixDigitPassword,
                            autovalidateMode:
                            AutovalidateMode
                                .onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            onFieldSubmitted: (_) {
                              createAccount();
                            },
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور',
                              counterText: '',
                              helperText: isPasswordFocused
                                  ? 'أدخل 6 أرقام'
                                  : null,
                              helperStyle: TextStyle(
                                color: primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: const TextStyle(
                                color: Color(0xff9AA7AB),
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: primaryColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword =
                                    !obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  obscurePassword
                                      ? Icons
                                      .visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color:
                                  const Color(0xff607D83),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: borderColor,
                                  width: 1.3,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.3,
                                ),
                              ),
                              focusedErrorBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: isSmallScreen ? 16 : 22,
                          ),

                          // Create Account
                          SizedBox(
                            width: double.infinity,
                            height: isSmallScreen ? 52 : 56,
                            child: ElevatedButton(
                              onPressed:
                              isLoading ? null : createAccount,
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor:
                                primaryColor.withOpacity(0.55),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                                  : Text(
                                'إنشاء حساب',
                                style: TextStyle(
                                  fontSize:
                                  isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Login link - matching login screen
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(18),
                              border: Border.all(
                                color: borderColor,
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'لديك حساب بالفعل؟',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize:
                                      isSmallScreen ? 14 : 16,
                                      color: darkColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: goToLogin,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 6,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.login,
                                          color: primaryColor,
                                          size: 21,
                                        ),
                                        const SizedBox(width: 5),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration nameInputDecoration({
    required String hint,
    required Color primaryColor,
    required Color borderColor,
  }) {
    return InputDecoration(
      hintText: hint,
      hintTextDirection: TextDirection.rtl,
      hintStyle: const TextStyle(
        color: Color(0xff9AA7AB),
        fontSize: 12,
      ),
      errorStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 17,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }
}