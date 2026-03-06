import 'package:flutter/material.dart';
import '../logic/system_controller_logic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color goldColor = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("AGENT PROFILE", 
          style: TextStyle(color: goldColor, letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
             children: [
              const SizedBox(height: 20),
               
                   Center(
                   child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                             shape: BoxShape.circle,
                        border: Border.all(color: goldColor, width: 2),
                          boxShadow: [
                          ],
                      ),
                  child: const CircleAvatar( 
                    radius: 50,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage('https://api.dicebear.com/7.x/bottts/png?seed=Kivuli'),
                ),
             ),
           ),
           const SizedBox(height: 15),
            Text(
               SystemController.data.agentName.toUpperCase(),
                style: const TextStyle(color: goldColor, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
            const Text(
              "STATUS: ACTIVE / ENCRYPTED",
              style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    const Text("SYSTEM OPERATIONS", 
                      style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  _buildActionTile(Icons.lock_clock, "SECURE_VAULT", "ACCESS_HIDDEN_DATA", () {
                      print("Vault Open");
                  }),
                  _buildActionTile(Icons.settings_input_antenna, "SIGNAL_ALERTS", "MANAGE_ENCRYPTION", () {
                    print("Signals Active");
                  }),
                  _buildActionTile(Icons.map_outlined, "RADAR_RANGE", "CALIBRATE_DISTANCE", () {
                    print("Radar Scanning");
                  }),
                   _buildActionTile(Icons.phonelink_lock, "NETWORK_PROXY", "IP_MASKING_ACTIVE", () {
                      print("Proxy Active");
                  }),
                   
                  const SizedBox(height: 20),
                   const Text("CRITICAL ACTIONS", 
                      style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 10),

                  _buildActionTile(Icons.delete_forever, "DATA_PURGE", "SELF_DESTRUCT_MODE", () {
                    print("Purging Data...");
                  }),
                 ],
              ),
             ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
    
  Widget _buildActionTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
         color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
       ),
        child: ListTile(
        onTap: onTap,
         leading: Icon(icon, color: const Color(0xFFD4AF37)),
         title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
         subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFD4AF37), size: 14),
      ),
    );
  }
  }
  
                   
                   
                    
                    
