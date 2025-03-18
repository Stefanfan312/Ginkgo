import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../theme/app_theme.dart';

/// 视频播放页面
/// 
/// 为老年用户提供简洁易用的视频播放界面，包括：
/// - 视频播放器
/// - 播放控制（播放/暂停、进度条）
/// - 全屏切换
/// - 视频信息
class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String lessonTitle;
  
  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.lessonTitle,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  bool _isControlsVisible = true;
  double _playbackSpeed = 1.0;
  
  // 控制栏显示计时器
  Timer? _hideControlsTimer;
  bool _isVideoEnded = false;
  
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }
  
  Future<void> _initializeVideoPlayer() async {
    // 根据URL类型选择不同的初始化方式
    if (widget.videoUrl.startsWith('http')) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    } else {
      _controller = VideoPlayerController.asset(widget.videoUrl);
    }
    
    // 初始化控制器
    await _controller.initialize();
    
    // 设置循环播放
    await _controller.setLooping(false);
    
    // 添加监听器
    _controller.addListener(_videoListener);
    
    // 更新状态
    if (mounted) {
      setState(() {
        _isInitialized = true;
        // 自动开始播放
        _controller.play();
        _isPlaying = true;
      });
    }
  }
  
  void _videoListener() {
    // 监听播放状态变化
    final bool isPlaying = _controller.value.isPlaying;
    if (isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    }
    
    // 检测视频是否播放结束
    if (_controller.value.position >= _controller.value.duration && 
        _controller.value.duration.inMilliseconds > 0 && 
        !_isVideoEnded) {
      setState(() {
        _isVideoEnded = true;
        _isControlsVisible = true; // 视频结束时显示控制栏
      });
      _cancelControlsTimer(); // 取消计时器，保持控制栏可见
    } else if (_controller.value.position < _controller.value.duration && _isVideoEnded) {
      setState(() {
        _isVideoEnded = false;
      });
    }
  }
  
  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = _controller.value.isPlaying;
      _resetControlsTimer();
    });
  }
  
  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        // 进入全屏模式，隐藏状态栏和导航栏
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        // 设置横屏
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        // 退出全屏模式，显示状态栏和导航栏
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        // 恢复竖屏
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
      _resetControlsTimer();
    });
  }
  
  void _toggleControls() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
      if (_isControlsVisible) {
        _resetControlsTimer();
      }
    });
  }
  
  void _cancelControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = null;
  }
  
  void _resetControlsTimer() {
    _cancelControlsTimer();
    
    // 只有在视频播放中且未结束时才设置隐藏计时器
    if (_isPlaying && !_isVideoEnded) {
      _hideControlsTimer = Timer(const Duration(seconds: 3), () {
        if (mounted && _isPlaying && !_isVideoEnded) {
          setState(() {
            _isControlsVisible = false;
          });
        }
      });
    }
  }
  
  void _setPlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
      _controller.setPlaybackSpeed(_playbackSpeed);
      _resetControlsTimer();
    });
  }
  
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    return duration.inHours > 0 
        ? '$hours:$minutes:$seconds' 
        : '$minutes:$seconds';
  }
  
  @override
  void dispose() {
    // 恢复系统UI设置
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _cancelControlsTimer();
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isFullScreen 
          ? null 
          : AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                widget.lessonTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppTheme.fontSizeMedium,
                ),
              ),
            ),
      body: _isInitialized 
          ? _buildVideoPlayer() 
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
            ),
    );
  }
  
  Widget _buildVideoPlayer() {
    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        children: [
          // 视频播放器
          Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          
          // 控制层
          if (_isControlsVisible)
            _buildControls(),
        ],
      ),
    );
  }
  
  Widget _buildControls() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withAlpha(128),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withAlpha(128),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 顶部控制栏
          _isFullScreen ? _buildTopControls() : const SizedBox(),
          
          // 底部控制栏
          _buildBottomControls(),
        ],
      ),
    );
  }
  
  Widget _buildTopControls() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (_isFullScreen) {
                // 如果是全屏状态，先退出全屏
                _toggleFullScreen();
              } else {
                Navigator.of(context).pop();
              }
            },
            tooltip: _isFullScreen ? '退出全屏' : '返回',
          ),
          Text(
            widget.lessonTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppTheme.fontSizeMedium,
            ),
          ),
          const SizedBox(width: 48), // 平衡布局
        ],
      ),
    );
  }
  
  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        children: [
          // 进度条
          _buildProgressBar(),
          const SizedBox(height: AppTheme.spacingSmall),
          
          // 播放控制
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 时间显示
              Text(
                '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppTheme.fontSizeSmall,
                ),
              ),
              
              // 播放/暂停按钮
              IconButton(
                iconSize: 48,
                icon: Icon(
                  _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: Colors.white,
                ),
                onPressed: _togglePlayPause,
              ),
              
              // 右侧控制按钮组
              Row(
                children: [
                  // 播放速度
                  PopupMenuButton<double>(
                    icon: const Icon(Icons.speed, color: Colors.white),
                    onSelected: _setPlaybackSpeed,
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 0.5, child: Text('0.5x')),
                      const PopupMenuItem(value: 0.75, child: Text('0.75x')),
                      const PopupMenuItem(value: 1.0, child: Text('1.0x (正常)')),
                      const PopupMenuItem(value: 1.25, child: Text('1.25x')),
                      const PopupMenuItem(value: 1.5, child: Text('1.5x')),
                    ],
                    tooltip: '播放速度',
                  ),
                  
                  // 全屏切换
                  IconButton(
                    icon: Icon(
                      _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                      color: Colors.white,
                    ),
                    onPressed: _toggleFullScreen,
                    tooltip: _isFullScreen ? '退出全屏' : '全屏',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildProgressBar() {
    return VideoProgressIndicator(
      _controller,
      allowScrubbing: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      colors: VideoProgressColors(
        playedColor: AppTheme.primaryColor,
        bufferedColor: Colors.white.withAlpha(128),
        backgroundColor: Colors.white.withAlpha(51),
      ),
    );
  }
}