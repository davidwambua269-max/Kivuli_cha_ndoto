// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/data_logic.dart';
import 'video_call_screen.dart';
import 'call_screen.dart';
import 'chat_history_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String clientName;
  final List<String> history;
  
  const ChatScreen({
    Key? key,
    required this.clientName,
    required this.history,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  // Rangi ya Gold ya Sci-Tech
  final Color goldColor = const Color(0xFFFFD700);

  void _sendMessage() async {
    final dataLogic = Provider.of<DataLogic>(context, listen: false);

    if (_messageController.text.isNotEmpty) {
      String message = _messageController.text;
      
      dataLogic.sendCommand(message);
      _messageController.clear();

      await FirebaseFirestore.instance.collection('chats').add({
        'text': message,
        'senderId': 'mteja_id',
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Kodi ya kutuma kwenye Firebase");
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Unganisha na DataLogic
    final dataLogic = Provider.of<DataLogic>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1,
        title: Text(dataLogic.agentName ?? widget.clientName),
        actions: [
          // --- KODI YA KIBADILISHA ICON
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatHistoryScreen(),
                ),
              );
            },
          ),
          
          // --- VITUFE VYA CALL
          IconButton(
            icon: Icon(Icons.call_outlined, color: goldColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CallScreen()),
              );
              // Weka kazi ya Call hapa
            },
          ),
          IconButton(
            icon: Icon(Icons.video_call_outlined, color: goldColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VideoCallScreen()),
              );
              // Weka kazi ya Video Call hapa
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Eneo la Ujumbe
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: dataLogic.messages.length,
              itemBuilder: (context, index) {
                final msg = dataLogic.messages[index];
                return Align(
                  alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: msg['isMe'] ? goldColor.withOpacity(0.2) : Colors.grey[900],
                      border: Border.all(color: msg['isMe'] ? goldColor : Colors.transparent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      msg['text'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Loading indicator kama data inachakatwa
          if (dataLogic.isLoading) const LinearProgressIndicator(),

          // Eneo la Kuandika (Bottom Bar)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[900],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Andika amri hapa...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // --- KITUFE CHA KUTUMA
                IconButton(
                  icon: Icon(Icons.send, color: goldColor),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
