import 'package:coinpay_app/screens/support_chat.dart';
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
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.contentPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Support', style: TextStyle(fontFamily: 'Poppins', color: AppColors.contentPrimary)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Top UI (optional start page before chat)
          if (messages.length == 1) ...[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    Image.asset(
                      'assets/icons/chat-bot.svg', 
                      height: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox(
                          height: 200,
                          child: Icon(
                            Icons.support_agent,
                            size: 100,
                            color: AppColors.contentDisabled,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'CoinPay Support',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: AppColors.contentPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Our dedicated team is here to assist you\nwith any questions or issues related to our\nCoinPay mobile app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14, 
                        color: AppColors.contentTertiary, 
                        fontFamily: 'Poppins',
                        height: 1.5,
                      ),
                    ),
                    const Spacer(flex: 1),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        icon: SvgPicture.asset(
                          'assets/icons/chat.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            AppColors.contentOnColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: const Text('Start Chat', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Support2Screen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.contentOnColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.help_outline, color: AppColors.primary),
                        label: Text('View FAQ', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary)),
                        onPressed: () {
                          // Navigasi ke halaman FAQ nanti
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primary, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
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
                        color: isBot ? AppColors.divider : AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg['text'],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: isBot ? AppColors.contentPrimary : AppColors.contentOnColor,
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
              color: AppColors.bgLight,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(fontFamily: 'Poppins', color: AppColors.contentTertiary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send, color: AppColors.primary),
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
              color: AppColors.contentPrimary.withValues(alpha: 0.5),
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
            _buildNavItem(context, 'assets/icons/chat-2.svg', 'Support', isActive: true),
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