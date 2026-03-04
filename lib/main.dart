// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/data_logic.dart'; // <--- Hakikisha path ni sahihi
import 'screens/dashboard_screen.dart'; // <--- Hapa ndipo tulipoita Dashboard

void main() {
  runApp(
      // --- 1. WEKA PROVIDER HAPA JUU ---
    ChangeNotifierProvider(
      create: (context) => DataLogic(),
      child: const KivuliChaNdotoApp(),
     ),  
  );
}

class KivuliChaNdotoApp extends StatelessWidget {
  const KivuliChaNdotoApp({super.key});
  
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kivuli cha Ndoto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Sci-Tech Gold Style
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DiscoveryHome(), // <--- 2. WEKA DASHBOARD HAPA
    );
  }
}
