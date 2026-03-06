import 'package:flutter/material.dart';
import '../logic/system_controller_logic.dart';

class RadarScreen extends StatefulWidget {
  const RadarScreen({super.key});

  @override
  State<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  final Color goldColor = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "KIVULI RADAR SYSTEM",
          style: TextStyle(
             color: goldColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
              fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
                 border: Border.all(color: goldColor.withOpacity(0.5)),
                 borderRadius: BorderRadius.circular(8),
              ),
                child: Text(
                 SystemController.radar.status.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                   color: goldColor,
                   fontSize: 13,
                ),
              ),
           ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Mabox mawili pembeni kwa pembeni
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8, // Inafanya mabox yawe marefu kidogo
              ),
              itemCount: 8, // Idadi ya Agents (Unaweza kuunganisha na data_logic baadae)
              itemBuilder: (context, index) {
                return Container(
                   decoration: BoxDecoration(
                    color: Colors.grey[900]?.withOpacity(0.5),
                     borderRadius: BorderRadius.circular(15),
                         border: Border.all(color: goldColor.withOpacity(0.4), width: 1),
                        ),
                        child: Stack(
                         children: [
                              Column(
                              children: [
                                  flex: 3,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                 image: const DecorationImage(
                                    fit: BoxFit.cover,
                                 ),
                               ),
                             ),
                           ),

                           Expanded(
                             flex: 1,
                             child: Column(      
                               mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "AGENT_ID_${index + 100}",
                                   style: TextStyle(
                                    color: goldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                               ),
                                const SizedBox(height: 2),
                                 const Text(
                                  "LOCATION: ENCRYPTED",
                                  style: TextStyle(color: Colors.white54, fontSize: 8),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        top: 12,
                        right: 12,
                        child: Row(
                          children: [
                            Icon(Icons.wifi_tethering, color: goldColor, size: 12),
                            const SizedBox(width: 4),
                            const Text(
                              style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),       
                    ],
                 ),
              );
           },
        ),
    }
}
                                                                           
