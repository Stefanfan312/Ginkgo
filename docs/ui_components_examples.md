# 银杏应用 UI 组件样式示例

本文档提供银杏应用UI组件的具体实现示例，帮助开发团队在实现界面时保持一致的设计风格。

## 按钮组件

### 主要按钮

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF0D8B70), // 银杏绿
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 2,
  ),
  onPressed: () {
    // 按钮点击事件
  },
  child: const Text(
    '主要按钮',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  ),
)
```

### 次要按钮

```dart
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF0D8B70), // 银杏绿
    side: const BorderSide(color: Color(0xFF0D8B70), width: 2),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  onPressed: () {
    // 按钮点击事件
  },
  child: const Text(
    '次要按钮',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  ),
)
```

### 文本按钮

```dart
TextButton(
  style: TextButton.styleFrom(
    foregroundColor: const Color(0xFF0D8B70), // 银杏绿
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  onPressed: () {
    // 按钮点击事件
  },
  child: const Text(
    '文本按钮',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  ),
)
```

## 输入框组件

```dart
TextField(
  decoration: InputDecoration(
    labelText: '输入框标签',
    hintText: '请输入内容',
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
    labelStyle: const TextStyle(fontSize: 16),
    contentPadding: const EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF0D8B70), width: 2),
    ),
  ),
  style: const TextStyle(fontSize: 18),
)
```

## 卡片组件

```dart
Card(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  margin: const EdgeInsets.all(8),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '卡片标题',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          '卡片内容描述，这里是卡片的详细信息。',
          style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D8B70),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {},
          child: const Text('操作按钮'),
        ),
      ],
    ),
  ),
)
```

## 列表项组件

```dart
ListTile(
  contentPadding: const EdgeInsets.all(16),
  leading: const Icon(
    Icons.person,
    size: 24,
    color: Color(0xFF0D8B70),
  ),
  title: const Text(
    '列表项标题',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  ),
  subtitle: const Text(
    '列表项描述内容',
    style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
  ),
  trailing: const Icon(
    Icons.arrow_forward_ios,
    size: 16,
    color: Color(0xFF757575),
  ),
  onTap: () {
    // 列表项点击事件
  },
)
```

## 开关按钮组件

```dart
Switch(
  value: true, // 开关状态
  activeColor: const Color(0xFF0D8B70), // 开启状态颜色
  inactiveThumbColor: Colors.white, // 关闭状态滑块颜色
  inactiveTrackColor: const Color(0xFFCCCCCC), // 关闭状态轨道颜色
  onChanged: (value) {
    // 状态变化回调
  },
)
```

## 底部导航栏组件

```dart
BottomNavigationBar(
  currentIndex: 0, // 当前选中项
  backgroundColor: Colors.white,
  selectedItemColor: const Color(0xFF0D8B70), // 选中项颜色
  unselectedItemColor: const Color(0xFF757575), // 未选中项颜色
  selectedFontSize: 14,
  unselectedFontSize: 14,
  type: BottomNavigationBarType.fixed,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 32),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school, size: 32),
      label: '学习',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people, size: 32),
      label: '社交',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, size: 32),
      label: '我的',
    ),
  ],
  onTap: (index) {
    // 导航项点击事件
  },
)
```

## 顶部导航栏组件

```dart
AppBar(
  backgroundColor: Colors.white,
  elevation: 1,
  centerTitle: true,
  title: const Text(
    '页面标题',
    style: TextStyle(
      color: Color(0xFF212121),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
  leading: IconButton(
    icon: const Icon(
      Icons.arrow_back,
      color: Color(0xFF212121),
      size: 24,
    ),
    onPressed: () {
      // 返回按钮点击事件
    },
  ),
  actions: [
    IconButton(
      icon: const Icon(
        Icons.share,
        color: Color(0xFF0D8B70),
        size: 24,
      ),
      onPressed: () {
        // 分享按钮点击事件
      },
    ),
  ],
)
```

## 对话框组件

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    title: const Text(
      '对话框标题',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    content: const Text(
      '对话框内容，这里是需要用户确认的信息。',
      style: TextStyle(fontSize: 18),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          '取消',
          style: TextStyle(
            color: Color(0xFF757575),
            fontSize: 18,
          ),
        ),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D8B70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          // 确认操作
        },
        child: const Text(
          '确认',
          style: TextStyle(fontSize: 18),
        ),
      ),
    ],
  ),
)
```

## 加载指示器组件

```dart
Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D8B70)),
        strokeWidth: 4,
      ),
      const SizedBox(height: 16),
      const Text(
        '加载中...',
        style: TextStyle(fontSize: 18, color: Color(0xFF757575)),
      ),
    ],
  ),
)
```

## 提示消息组件

```dart
SnackBar(
  backgroundColor: const Color(0xFF0D8B70),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  content: const Text(
    '操作成功！',
    style: TextStyle(fontSize: 16),
  ),
  action: SnackBarAction(
    label: '确定',
    textColor: Colors.white,
    onPressed: () {
      // 操作按钮点击事件
    },
  ),
)
```

## 图片展示组件

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.asset(
    'assets/images/example.jpg',
    width: double.infinity,
    height: 200,
    fit: BoxFit.cover,
  ),
)
```

## 标签组件

```dart
Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  decoration: BoxDecoration(
    color: const Color(0xFFE8F5E9),
    borderRadius: BorderRadius.circular(8),
  ),
  child: const Text(
    '标签文本',
    style: TextStyle(
      color: Color(0xFF0D8B70),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
)
```