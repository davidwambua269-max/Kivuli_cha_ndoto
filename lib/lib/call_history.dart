import 'package:flutter/material.dart';
// import 'package:kivuli_app/service/chat_service.dart'; // Hapa tuta-import service halisi
import 'chat_screen.dart';
class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({Key? key}) : super(key: key);
  
  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final Color goldColor = const Color(0xFFFFD700);

   // Mfano wa list tupu (Real-time data itakuja hapa)
  List<Map<String, dynamic>> chatHistory = []; 
  
  @override
  void initState() {
    super.initState();
    // Hapa tuta-call service kupata data halisi
    _loadChatHistory();  
}

void _loadChatHistory() {
  setState(() {
      chatHistory = []; // <--- IJARIBU HII KAMA EMPTY LIST
    });
}
@override  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Historia ya Kivuli", style: TextStyle(color: goldColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: goldColor),
     ),
     body: chatHistory.isEmpty
        ? Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.forum_outlined, size: 80, color: goldColor.withOpacity(0.5)),
               const SizedBox(height: 20),
               Text(
                 "Hakuna mazungumzo ya zamani...",
                style: TextStyle(color: goldColor, fontSize: 18),
             ),
           ],
        ),
      )
    : ListView.builder(
        itemCount: chatHistory.length,
        itemBuilder: (context, index) {
        final chat = chatHistory[index];
        return ListTile(
          leading: CircleAvatar(
          child: const Icon(Icons.person, color: Colors.black),
       ),
       title: Text(chat['name'], style: TextStyle(color: goldColor)),
       subtitle: Text(chat['lastMessage'], style: const TextStyle(color: Colors.white70)),
       ontap: () {
         Navigation.push(
           context,
           MaterialPageRoute(
               builder: (context) => ChatScreen(
                 clientName: chat['name'],
                 history: chat['messages'],
                   ),
                       ),
                          );
                            },
           );
         },
       ),
    );
  }
}
