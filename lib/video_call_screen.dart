import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  RtcEngine? _engine;
  int? _remoteUid; // ID ya mtu unayempigia
  bool _localUserJoined = false;
  final String appId = "51335482e7c"; 

  @override
  void initState() {
    super.initState();
    setupVideoSDKEngine();
  }

  Future<void> setupVideoSDKEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() { _localUserJoined = true; });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() { _remoteUid = remoteUid; });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() { _remoteUid = null; });
        },
      ),
    );

    await _engine!.enableVideo();
    await _engine!.startPreview();

    await _engine!.joinChannel(
      token: '', 
      channelId: "kivuli_video",
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    _engine?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color goldColor = const Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Video ya Mtu wa mbali (Remote Video)
          Center(child: _remoteVideoView(goldColor)),

          // 2. Video yako (Local Preview) - Inakaa kona juu
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              width: 120,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: goldColor, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: _localUserJoined 
                  ? AgoraVideoView(controller: VideoViewController(rtcEngine: _engine!, canvas: const VideoCanvas(uid: 0)))
                  : const Center(child: CircularProgressIndicator(color: Color(0xFFFFD700))),
              ),
            ),
          ),

          // 3. Vifungo vya chini (Sci-Tech Style)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.mic, goldColor),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
                _buildActionButton(Icons.switch_video, goldColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Muonekano wa Video ya mbali
  Widget _remoteVideoView(Color gold) {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine!,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: "kivuli_video"),
        ),
      );
    } else {
      return Text(
        "WAITING FOR AGENT...",
        style: TextStyle(color: gold, letterSpacing: 3, fontWeight: FontWeight.bold),
      );
    }
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1),
      ),
      child: IconButton(icon: Icon(icon, color: color), onPressed: () {}),
    );
  }
}








