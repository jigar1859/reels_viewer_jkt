import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:reels_viewer/src/models/reel_model.dart';
import 'package:reels_viewer/src/services/video_controller_service.dart';
import 'package:reels_viewer/src/utils/log_util.dart';
import 'package:reels_viewer/src/utils/url_checker.dart';
import 'package:video_player/video_player.dart';
import 'components/like_icon.dart';
import 'components/screen_options.dart';

class ReelsPage extends StatefulWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final SwiperController swiperController;
  final bool showProgressIndicator;
  final bool autoAdvance;

  const ReelsPage({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.showProgressIndicator = true,
    this.autoAdvance = false,

    required this.swiperController,
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  VoidCallback? _videoListener;
  @override
  void initState() {
    super.initState();
    if (!UrlChecker.isImageUrl(widget.item.url) &&
        UrlChecker.isValid(widget.item.url)) {
      // Initialize all videos immediately
      initializePlayer();
    }
  }

  Future initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.item.url);
      await _videoPlayerController!.initialize();
      
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        showControls: true,
        looping: true,
      );
      
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getVideoView();
  }

  Widget getVideoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? (_videoPlayerController?.value.hasError == true
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 60),
                        SizedBox(height: 16),
                        Text(
                          'Failed to load video',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.item.url,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            initializePlayer();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (!widget.item.isLiked) {
                            _liked = true;
                            if (widget.onLike != null) {
                              widget.onLike!(widget.item.url);
                            }
                            setState(() {});
                          }
                        },
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      ),
                    ),
                  ))
            : Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Loading video...',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.item.url,
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
        if (_liked)
          const Center(
            child: LikeIcon(),
          ),
        if (widget.showProgressIndicator && _videoPlayerController != null)
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: VideoProgressIndicator(
              _videoPlayerController!,
              allowScrubbing: false,
              colors: const VideoProgressColors(
                backgroundColor: Colors.blueGrey,
                bufferedColor: Colors.blueGrey,
                playedColor: Colors.blueAccent,
              ),
            ),
          ),
        ScreenOptions(
          onClickMoreBtn: widget.onClickMoreBtn,
          onComment: widget.onComment,
          onFollow: widget.onFollow,
          onLike: widget.onLike,
          onShare: widget.onShare,
          showVerifiedTick: widget.showVerifiedTick,
          item: widget.item,
        )
      ],
    );
  }
}
