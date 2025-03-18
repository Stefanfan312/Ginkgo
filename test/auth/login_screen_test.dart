import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo_app/app/screens/auth/login_screen.dart';

void main() {
  // 测试组：登录页面
  group('LoginScreen UI Tests', () {
    // 测试用例：验证登录页面基本UI元素
    testWidgets('应显示基本UI元素和布局', (WidgetTester tester) async {
      // 构建Widget
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );
      
      // 验证页面结构元素存在
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(TextField), findsAtLeast(1));
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
    });
  });
}