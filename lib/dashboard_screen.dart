import 'package:flutter/material.dart';
import 'premium_drawer_screen.dart';
import 'radar_screen.dart';
import 'profile_screen.dart';
import 'chat_screen.dart';
import 'vault_screen.dart';
import 'package:kivuli_app/logic/uchumi_logic_service.dart';

class DiscoveryHome extends StatefulWidget {
  const DiscoveryHome({super.key});

  @override
  State<DiscoveryHome> createState() => _DiscoveryHomeState();
}

class _DiscoveryHomeState extends State<DiscoveryHome> {
  final UchumiLogicService _uchumiService = UchumiLogicService();
  
  // Sehemu ya kudhibiti kurasa (Navigation)
  int _currentIndex = 0;

  // Rangi yetu kuu ya dhahabu (Gold)
  final Color goldColor = const Color(0xFFFFD700);

  // Orodha ya kurasa zitakazobadilika
  final List<Widget> _pages = [
    const RadarScreen(),
    ChatScreen(
      clientName: "Chat Mpya",
      history: [],
    ),
    const VaultScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // HAPA TUNAIUNGANISHA ILE DRAWER
      // Hii ndio itafunguka ukibonyeza icon ya dhahabu
      drawer: const PremiumDrawerScreen(),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,

        // KUBADILISHA ICON YA DRAWER IWE YA DHAHABU
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.stars_rounded,
              color: goldColor,
              size: 28,
            ), // Icon
            onPressed: () {
              // Amri ya kufungua drawer
              Scaffold.of(context).openDrawer();
            },
          ), // IconButton
        ), // Builder

        // Title inayobadilika kulingana na ukurasa
        title: Text(
          _currentIndex == 0 ? "KIVULI RADAR" : "KIVULI SYSTEM",
          style: TextStyle(
            color: goldColor,
            fontSize: 11,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ), // TextStyle
        ), // Text

        // Icon ya ziada kwa upande wa kulia
        actions: [
          IconButton(
            icon: Icon(Icons.calculate_outlined, color: goldColor),
            onPressed: () {
              String matokeo = _uchumiService.valuateItem("Dhahabu");
              print(matokeo);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(matokeo)),
              );
            },
          ), // IconButton
        ],
      ), // AppBar

      // MWILI WA APP (Hapa ndipo kurasa zinakaa)
      body: _pages[_currentIndex],

      // NAVIGATION YA CHINI (BOTTOM NAVBAR)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: goldColor, width: 0.2)),
        ), // BoxDecoration
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.black,
          selectedItemColor: goldColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10,
          unselectedFontSize: 9,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            // Badilisha ukurasa
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.radar_outlined),
              activeIcon: Icon(Icons.radar),
              label: 'RADAR_SYSTEM',
            ), // BottomNavigationBarItem
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'CHAT',
            ), // BottomNavigationBarItem
            BottomNavigationBarItem(
              icon: Icon(Icons.key_outlined),
              activeIcon: Icon(Icons.key),
              label: 'VAULT',
            ), // BottomNavigationBarItem
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'IDENTITY',
            ) // BottomNavigationBarItem
          ],
        ), // BottomNavigationBar
      ), // Container
    ); // Scaffold
  }
}
