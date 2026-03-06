import 'package:flutter/material.dart';
import 'vault_screen.dart';
import '../logic/system_controller.dart'; // Nimeikamilisha kulingana na muundo wa picha

class PremiumDrawer extends StatefulWidget {
  const PremiumDrawer({super.key});

  @override
  State<PremiumDrawer> createState() => _PremiumDrawerState();
}

class _PremiumDrawerState extends State<PremiumDrawer> {
  final Color goldColor = const Color(0xFFFFD700);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(bottom: BorderSide(color: Color(0xFFFFD700), width: 0.5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Icon(Icons.monetization_on_outlined, color: Color(0xFFFFD700), size: 50),
                const SizedBox(height: 10),
                const Text("CURRENT_BALANCE", style: TextStyle(color: Colors.white)),
                Text("${SystemController.balance}", style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentGatewayScreen()));
                    },
                    child: const Text("BUY PREMIUM"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildDrawerItem(Icons.workspace_premium_outlined, "MAMBO YA PREMIUM", onTap: () {}),
          _buildDrawerItem(Icons.stars_rounded, "CHAGUA VIP / VVIP", onTap: () {}),
          const Divider(color: Colors.white24),
          _buildDrawerItem(Icons.monetization_on_outlined, "FREE COINS (ADS)", onTap: () {}),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.security, color: Colors.grey),
                const SizedBox(height: 10),
                const Text("SECURE_PAYMENT_BY_M_PESA", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFFD700), size: 22),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400)),
      onTap: onTap,
    );
  }
}
