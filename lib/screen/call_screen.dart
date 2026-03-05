import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class CallScreen extends StatefulWidget {
  final String callerName;
  const CallScreen({super.key, required this.callerName});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  RtcEngine? _engine;
  final String appId = "51335482e7c"; // ID yako ya Agora

  @override
  void initState() {
    super.initState();
    setupVoiceSDKEngine(); // Tumeshaunganisha hapa
  }

  Future<void> setupVoiceSDKEngine() async {
    // Tunatengeneza engine
    _engine = createAgoraRtcEngine();
    
    // Tunaitoa 'const' hapa ili appId isomeke
    await _engine!.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    await _engine!.disableVideo(); // Hii ni Voice Call tu

    // Jiunge kwenye chumba (Channel)
    await _engine!.joinChannel(
      token: '', // Weka token kama unatumia security
      channelId: "kivuli_voice",
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    // Hii ndio method uliyokuwa unaulizia, sasa ipo mahali sahihi
    _engine?.leaveChannel();
    _engine?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Rangi ya Gold ya Sci-Tech kwa ajili ya Kivuli cha Ndoto
    final Color goldColor = const Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: Colors.black, // Background nyeusi kwa sci-tech style
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Voice Call", style: TextStyle(color: Color(0xFFFFD700))),
        bottom: TabBar(
          indicatorColor: goldColor,
          tabs: const [
            Tab(icon: Icon(Icons.history, color: Color(0xFFFFD700))),
            Tab(icon: Icon(Icons.contacts, color: Color(0xFFFFD700))),
            Tab(icon: Icon(Icons.settings, color: Color(0xFFFFD700))),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon kubwa ya Agent
            Icon(Icons.person, size: 100, color: goldColor),
            const SizedBox(height: 20),
            Text(
              widget.callerName.toUpperCase(),
              style: TextStyle(color: goldColor, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const Text("AGENT ZERO - ON CALL", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 50),
            
            // Kitufe cha kukata simu
            FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.call_end, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
