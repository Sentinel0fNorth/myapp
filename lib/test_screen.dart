import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer';

class TestScreen extends StatefulWidget {
  final String testName;
  const TestScreen({super.key, required this.testName});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _hasVideoFile = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  String _getVideoPath(String testName) {
    switch (testName.toLowerCase()) {
      case 'vertical jump test':
        return 'assets/videos/vertical_jump_instructions.mp4';
      case 'sit-ups test':
        return 'assets/videos/situps_instructions.mp4';
      default:
        return 'assets/videos/default_instructions.mp4';
    }
  }

  Future<void> _initializeVideo() async {
    try {
      final videoPath = _getVideoPath(widget.testName);
      _videoController = VideoPlayerController.asset(videoPath);
      await _videoController!.initialize();
      setState(() {
        _isVideoInitialized = true;
        _hasVideoFile = true;
      });
    } catch (e) {
      log('Video file not found: $e');
      setState(() {
        _hasVideoFile = false;
        _isVideoInitialized = true; // Mark as "initialized" to show placeholder
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.testName, style: GoogleFonts.poppins()),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/main'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Instructions', style: theme.textTheme.headlineSmall?.copyWith(fontFamily: 'Poppins')),
              const SizedBox(height: 8),
              const Text(
                'Record your video in a well-lit environment. Keep your camera stable and follow the steps shown in the instruction video below.',
              ),
              const SizedBox(height: 24),
              _buildVideoPlayer(theme),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    log('Record button pressed for: ${widget.testName}');
                  },
                  child: const Text('Upload'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(ThemeData theme) {
    if (!_isVideoInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (!_hasVideoFile) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.video_library_outlined, 
                   size: 48, 
                   color: Colors.grey.shade600),
              const SizedBox(height: 8),
              Text(
                'Instruction video for ${widget.testName}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Video file not found',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: VideoPlayer(_videoController!),
          ),
        ),
        const SizedBox(height: 16),
        _buildVideoControls(theme),
      ],
    );
  }

  Widget _buildVideoControls(ThemeData theme) {
    if (_videoController == null || !_hasVideoFile) return const SizedBox();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_videoController!.value.isPlaying) {
                  _videoController!.pause();
                } else {
                  _videoController!.play();
                }
              });
            },
            icon: Icon(
              _videoController!.value.isPlaying 
                  ? Icons.pause_circle_filled 
                  : Icons.play_circle_filled,
              size: 32,
              color: theme.colorScheme.primary,
            ),
          ),
          Expanded(
            child: VideoProgressIndicator(
              _videoController!,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: theme.colorScheme.primary,
                bufferedColor: theme.colorScheme.primary.withOpacity(0.3),
                backgroundColor: Colors.grey.shade300,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatDuration(_videoController!.value.position),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            ' / ',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          Text(
            _formatDuration(_videoController!.value.duration),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
