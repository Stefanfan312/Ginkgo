import 'package:flutter/material.dart';

/// 应用主题配置
/// 
/// 为老年人设计的主题，包括：
/// - 大字体
/// - 高对比度颜色
/// - 简洁的视觉元素
class AppTheme {
  // 防止实例化
  AppTheme._();
  
  // 主色调 - 银杏黄
  static const Color primaryColor = Color(0xFFFFD700);
  // 次要色调 - 银杏绿
  static const Color secondaryColor = Color(0xFF7CB342);
  // 背景色 - 浅色
  static const Color backgroundColor = Color(0xFFF5F5F5);
  // 卡片背景色
  static const Color cardColor = Colors.white;
  // 错误色
  static const Color errorColor = Color(0xFFD32F2F);
  
  // 文本颜色 - 深色，确保高对比度
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  
  // 字体大小 - 适合老年人的大字体
  static const double fontSizeExtraSmall = 14.0;
  static const double fontSizeSmall = 16.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeLarge = 22.0;
  static const double fontSizeExtraLarge = 26.0;
  
  // 圆角大小
  static const double borderRadius = 12.0;
  
  // 间距
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  
  // 图标大小
  static const double iconSizeSmall = 24.0;
  static const double iconSizeMedium = 32.0;
  static const double iconSizeLarge = 40.0;
  
  // 亮色主题
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: cardColor,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: textPrimaryColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: fontSizeExtraLarge, fontWeight: FontWeight.bold, color: textPrimaryColor),
      displayMedium: TextStyle(fontSize: fontSizeLarge, fontWeight: FontWeight.bold, color: textPrimaryColor),
      displaySmall: TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.bold, color: textPrimaryColor),
      headlineMedium: TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.w600, color: textPrimaryColor),
      titleLarge: TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.w600, color: textPrimaryColor),
      titleMedium: TextStyle(fontSize: fontSizeSmall, fontWeight: FontWeight.w600, color: textPrimaryColor),
      bodyLarge: TextStyle(fontSize: fontSizeMedium, color: textPrimaryColor),
      bodyMedium: TextStyle(fontSize: fontSizeSmall, color: textPrimaryColor),
      bodySmall: TextStyle(fontSize: fontSizeExtraSmall, color: textSecondaryColor),
    ),
    fontFamily: 'GinkgoFont',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: spacingLarge, vertical: spacingMedium),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        elevation: 2,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: spacingLarge, vertical: spacingMedium),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        side: const BorderSide(color: primaryColor, width: 2),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: spacingMedium, vertical: spacingSmall),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(spacingMedium),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      labelStyle: const TextStyle(fontSize: fontSizeSmall, color: textSecondaryColor),
      hintStyle: TextStyle(fontSize: fontSizeSmall, color: Colors.grey.shade400),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      margin: const EdgeInsets.all(spacingSmall),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: fontSizeLarge, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: const TextStyle(fontSize: fontSizeSmall, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: fontSizeSmall),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade300,
      thickness: 1,
      space: spacingMedium,
    ),
    iconTheme: const IconThemeData(
      color: textPrimaryColor,
      size: iconSizeMedium,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
      size: iconSizeMedium,
    ),
  );
  
  // 深色主题
  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: Color(0xFF1E1E1E),
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    textTheme: TextTheme(
      displayLarge: const TextStyle(fontSize: fontSizeExtraLarge, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: const TextStyle(fontSize: fontSizeLarge, fontWeight: FontWeight.bold, color: Colors.white),
      displaySmall: const TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: const TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.w600, color: Colors.white),
      titleLarge: const TextStyle(fontSize: fontSizeMedium, fontWeight: FontWeight.w600, color: Colors.white),
      titleMedium: const TextStyle(fontSize: fontSizeSmall, fontWeight: FontWeight.w600, color: Colors.white),
      bodyLarge: const TextStyle(fontSize: fontSizeMedium, color: Colors.white),
      bodyMedium: const TextStyle(fontSize: fontSizeSmall, color: Colors.white),
      bodySmall: TextStyle(fontSize: fontSizeExtraSmall, color: Colors.grey.shade400),
    ),
    fontFamily: 'GinkgoFont',
    // 其他主题配置与亮色主题类似，但颜色适应深色模式
  );
}