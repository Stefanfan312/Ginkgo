import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo_app/app/models/activity.dart';
import 'package:ginkgo_app/app/screens/social/activity_detail_screen.dart';
import 'package:ginkgo_app/app/services/activity_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ActivityService])
import 'activity_detail_screen_test.mocks.dart';

void main() {
  late MockActivityService mockActivityService;
  late Activity mockActivity;

  setUp(() {
    mockActivityService = MockActivityService();
    // 注入ActivityService的依赖
    // 这里需要修改，因为ActivityService使用的是私有的_instance
    // 在实际应用中，应该提供一种方式来注入mock服务
    mockActivity = Activity(
      id: '1',
      title: '社区健康讲座',
      location: '阳光社区活动中心',
      time: '明天 14:00-16:00',
      participants: 28,
      image: 'assets/images/activity1.jpg',
      description: '关于健康生活的专业讲座',
      organizer: '社区服务中心',
      isFree: true,
      isJoined: false,
      isFavorite: false,
      tags: ['健康', '讲座'],
    );
  });

  group('ActivityDetailScreen UI Tests', () {
    testWidgets('应显示基本UI元素和布局', (WidgetTester tester) async {
      when(mockActivityService.getActivityDetail('1'))
          .thenAnswer((_) async => mockActivity);

      await tester.pumpWidget(
        MaterialApp(
          home: ActivityDetailScreen(activityId: '1'),
        ),
      );

      // 初始状态应显示加载指示器
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // 等待异步操作完成
      await tester.pump();

      // 验证活动详情是否正确显示
      expect(find.text('社区健康讲座'), findsOneWidget);
      expect(find.text('阳光社区活动中心'), findsOneWidget);
      expect(find.text('明天 14:00-16:00'), findsOneWidget);
      expect(find.text('关于健康生活的专业讲座'), findsOneWidget);
      expect(find.text('社区服务中心'), findsOneWidget);
    });

    testWidgets('测试报名功能', (WidgetTester tester) async {
      when(mockActivityService.getActivityDetail('1'))
          .thenAnswer((_) async => mockActivity);
      when(mockActivityService.joinActivity('1'))
          .thenAnswer((_) async => true);

      await tester.pumpWidget(
        MaterialApp(
          home: ActivityDetailScreen(activityId: '1'),
        ),
      );

      await tester.pump();

      // 点击报名按钮
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // 验证报名成功提示
      expect(find.text('报名成功！'), findsOneWidget);
      verify(mockActivityService.joinActivity('1')).called(1);
    });

    testWidgets('测试收藏功能', (WidgetTester tester) async {
      when(mockActivityService.getActivityDetail('1'))
          .thenAnswer((_) async => mockActivity);
      when(mockActivityService.favoriteActivity('1', true))
          .thenAnswer((_) async => true);

      await tester.pumpWidget(
        MaterialApp(
          home: ActivityDetailScreen(activityId: '1'),
        ),
      );

      await tester.pump();

      // 验证初始状态为未收藏
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);

      // 点击收藏按钮
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pump();

      // 验证收藏状态变化
      verify(mockActivityService.favoriteActivity('1', true)).called(1);
      
      // 模拟收藏后的状态变化，返回已收藏的Activity
      final favoriteActivity = mockActivity.copyWith(isFavorite: true);
      when(mockActivityService.getActivityDetail('1'))
          .thenAnswer((_) async => favoriteActivity);
      
      // 重新加载UI以反映状态变化
      await tester.pump();
      
      // 验证收藏按钮图标已更新
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);
    });
  });
}