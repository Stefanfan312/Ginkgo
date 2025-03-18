# 银杏应用

这是一个面向老年人的智能手机教学应用，通过视频或图文形式帮助65岁以上老年人学习使用智能手机。用户可以通过学习或分享获取积分，还可以发布内容到应用内的朋友圈，与其他用户互动。

## 项目目标

- 提供简单易懂的智能手机使用教程
- 建立老年人社交互动平台
- 通过积分系统激励用户学习和分享
- 未来扩展购物、兴趣群组、活动报名等功能

## 项目结构

- `lib/` - Flutter应用源代码
  - `app/` - 应用核心代码
    - `routes/` - 路由配置
    - `theme/` - 主题配置
    - `screens/` - 页面组件
    - `widgets/` - 可复用组件
    - `models/` - 数据模型
    - `services/` - 服务层
- `assets/` - 静态资源文件
  - `images/` - 图片资源
  - `icons/` - 图标资源
  - `videos/` - 视频资源
- `docs/` - 项目文档

## 开发指南

### 环境配置

1. 安装 [Flutter SDK](https://flutter.dev/docs/get-started/install)
2. 配置 Android Studio 或 VS Code 的 Flutter 插件
3. 运行 `flutter doctor` 确保环境配置正确
4. 运行 `flutter pub get` 安装依赖

### 运行项目

```bash
flutter run
```

## 技术栈

- **前端框架**: Flutter (跨平台支持 iOS、Android 和鸿蒙系统)
- **编程语言**: Dart
- **状态管理**: Provider
- **路由管理**: go_router
- **网络请求**: Dio, HTTP
- **本地存储**: Shared Preferences
- **媒体处理**: video_player, cached_network_image
- **UI组件**: Material Design, Cupertino
- **社交分享**: share_plus

## 设计原则

- 简洁清晰的界面设计
- 适合老年人的大字体和高对比度
- 直观的操作流程
- 减少复杂的手势操作
- 提供清晰的反馈和提示