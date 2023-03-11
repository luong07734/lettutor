import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'dart:async';

class VideoCallWidget extends StatefulWidget {
  @override
  _VideoCallWidgetState createState() => _VideoCallWidgetState();
}

class _VideoCallWidgetState extends State<VideoCallWidget> {
  bool _isMuted = false;
  bool _isCameraOff = false;
  bool _isScreenSharing = false;
  bool _isChatOpen = false;
  bool _isHandRaised = false;
  bool _isFullscreen = false;

  int _secondsElapsed = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Stack(
          children: [
            // Add your video call widget here
            // Example: VideoPlayer(controller),
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height / 3,
              child: CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.asset(
                    AssetsManager.avatarImage,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isMuted ? Icons.mic_off : Icons.mic,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isMuted = !_isMuted;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _isCameraOff ? Icons.videocam_off : Icons.videocam,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isCameraOff = !_isCameraOff;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _isScreenSharing
                            ? Icons.stop_screen_share
                            : Icons.screen_share,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isScreenSharing = !_isScreenSharing;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _isChatOpen ? Icons.chat_bubble_outline : Icons.chat,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isChatOpen = !_isChatOpen;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _isHandRaised
                            ? Icons.pan_tool_outlined
                            : Icons.pan_tool,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isHandRaised = !_isHandRaised;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _isFullscreen
                            ? Icons.fullscreen_exit
                            : Icons.fullscreen,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFullscreen = !_isFullscreen;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Add your settings functionality here
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.call_end,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Add your end call functionality here
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  _formatDuration(Duration(seconds: _secondsElapsed)),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
