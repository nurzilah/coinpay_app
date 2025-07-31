import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coinpay_app/constants/color.dart';
import 'package:coinpay_app/screens/home.dart';
import 'package:coinpay_app/screens/spending.dart';
import 'package:coinpay_app/screens/qris.dart';
import 'package:coinpay_app/screens/profile.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      'fromBot': true,
      'text': 'Welcome to CoinPay support!\nHow can we assist you today?\n\nWhat is your question regarding?\nAre you having a problem with a specific feature?\nHave you tried troubleshooting steps we provided in FAQ or other documentation?'
    },
  ];

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'fromBot': false, 'text': text});
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Support', style: TextStyle(fontFamily: 'Poppins', color: Colors.black)),
      ),
      body: Column(
        children: [
          // Top UI (optional start page before chat)
          if (messages.length == 1) ...[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/images/support_illustration.png', 
                      height: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          child: Icon(
                            Icons.support_agent,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'CoinPay Support',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Our dedicated team is here to assist you\nwith any questions or issues related to our app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.chat_bubble_outline),
                        label: const Text('Start Chat', style: TextStyle(fontFamily: 'Poppins')),
                        onPressed: () => setState(() {}),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.help_outline),
                        label: const Text('View FAQ', style: TextStyle(fontFamily: 'Poppins')),
                        onPressed: () {
                          // Navigasi ke halaman FAQ nanti
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100), // Bottom padding for navigation
                  ],
                ),
              ),
            )
          ]
          else ...[
            // Chat content
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isBot = msg['fromBot'];
                  return Align(
                    alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(maxWidth: 280),
                      decoration: BoxDecoration(
                        color: isBot ? Colors.grey.shade200 : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg['text'],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: isBot ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Chat input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: const TextStyle(fontFamily: 'Poppins'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, color: Colors.blue),
                  )
                ],
              ),
            ),
          ]
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          boxShadow: [
            BoxShadow(
              color: AppColors.contentPrimary.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, 'assets/icons/home.svg', 'Home', isActive: false),
            _buildNavItem(context, 'assets/icons/chart-pie.svg', 'Spending', isActive: false),
            _buildNavItem(context, 'assets/icons/scanner.svg', 'QR', isActive: false, isCenter: true),
            _buildNavItem(context, 'assets/icons/chat.svg', 'Support', isActive: true),
            _buildNavItem(context, 'assets/icons/user.svg', 'Profile', isActive: false),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavItem(
    BuildContext context,
    String iconPath,
    String label, {
    required bool isActive,
    bool isCenter = false,
  }) {
    return GestureDetector(
      onTap: () => _handleNavTap(context, label),
      child: isCenter 
        ? Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.contentOnColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    isActive ? AppColors.primary : AppColors.contentTertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isActive 
                    ? AppColors.primary 
                    : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
    );
  }

  // Handler functions for navigation
  void _handleNavTap(BuildContext context, String navItem) {
    switch (navItem) {
      case 'Home':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 'Spending':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SpendingScreen()),
        );
        break;
      case 'QR':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const QrisScreen()),
        );
        break;
      case 'Support':
        break;
      case 'Profile':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }
}