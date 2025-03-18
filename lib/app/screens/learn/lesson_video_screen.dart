import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../theme/app_theme.dart';

/// 课程视频播放页面
/// 
/// 为老年用户提供简洁易用的视频播放界面，包括：
/// - 视频播放器
/// - 播放控制按钮
/// - 进度条
/// - 课程信息
class LessonVideoScreen extends StatefulWidget {
  final String videoUrl;
  final String lessonTitle;
  
  const LessonVideoScreen({
    super.key,
    required this.videoUrl,
    required this.lessonTitle,
  });

  @override
  State<LessonVideoScreen> createState() => _LessonVideoScreenState();
}

class _LessonVideoScreenState extends State<LessonVideoScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _showControls = true;
  
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    
    // 自动隐藏控制栏
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }
  
  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.asset(widget.videoUrl);
    await _controller.initialize();
    
    // 添加监听器，更新播放状态
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
    
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = _controller.value.isPlaying;
      
      // 显示控制栏
      _showControls = true;
      
      // 如果正在播放，延迟隐藏控制栏
      if (_isPlaying) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted && _isPlaying) {
            setState(() {
              _showControls = false;
            });
          }
        });
      }
    });
  }
  
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    
    // 如果显示了控制栏且视频正在播放，延迟隐藏控制栏
    if (_showControls && _isPlaying) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _isPlaying) {
          setState(() {
            _showControls = false;
          });
        }
      });
    }
  }
  
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    return hours == '00' ? '$minutes:$seconds' : '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // 视频播放器
            Center(
              child: _isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: GestureDetector(
                        onTap: _toggleControls,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    ),
            ),
            
            // 控制栏 - 顶部
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: AppTheme.iconSizeMedium,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: AppTheme.spacingMedium),
                    Expanded(
                      child: Text(
                        widget.lessonTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppTheme.fontSizeMedium,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // 控制栏 - 底部
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.spacingMedium),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 进度条
                      _isInitialized
                          ? VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: AppTheme.primaryColor,
                                bufferedColor: Colors.grey,
                                backgroundColor: Colors.grey,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: AppTheme.spacingSmall,
                              ),
                            )
                          : const SizedBox(),
                      
                      const SizedBox(height: AppTheme.spacingSmall),
                      
                      // 播放控制和时间
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 当前时间
                          _isInitialized
                              ? Text(
                                  _formatDuration(_controller.value.position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: AppTheme.fontSizeSmall,
                                  ),
                                )
                              : const SizedBox(),
                          
                          // 播放/暂停按钮
                          IconButton(
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: AppTheme.iconSizeLarge,
                            ),
                            onPressed: _isInitialized ? _togglePlayPause : null,
                          ),
                          
                          // 总时长
                          _isInitialized
                              ? Text(
                                  _formatDuration(_controller.value.duration),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: AppTheme.fontSizeSmall,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // 老年人友好的大按钮控制层
            if (_isInitialized && !_showControls)
              GestureDetector(
                onTap: _toggleControls,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        color: Colors.white.withOpacity(0.5),
                        size: 80,
                      ),
                      onPressed: _togglePlayPause,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}