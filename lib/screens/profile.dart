import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coinpay_app/screens/home.dart';
import 'package:coinpay_app/screens/spending.dart';
import 'package:coinpay_app/screens/qris.dart';
import 'package:coinpay_app/screens/support.dart';
import 'package:coinpay_app/constants/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;

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
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Picture
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/pp_linkedin.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nurzilah Hidayati',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text('nurzilah.hyt@gmail.com', style: TextStyle(color: Colors.grey)),
                  const Text('+6285712799296', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSettings(),
            const SizedBox(height: 100), // Bottom padding for navigation
          ],
        ),
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
            _buildNavItem(context, 'assets/icons/chat.svg', 'Support', isActive: false),
            _buildNavItem(context, 'assets/icons/user.svg', 'Profile', isActive: true),
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SupportScreen()),
        );
        break;
      case 'Profile':
        // Already on profile screen
        break;
    }
  }

  Widget _buildSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem(Icons.dark_mode, Colors.grey, 'Dark Mode',
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) => setState(() => isDarkMode = value),
                activeColor: Colors.blue,
              )),
          _buildSettingsItem(Icons.person_outline, Colors.blue, 'Personal Info'),
          _buildSettingsItem(Icons.account_balance_wallet_outlined, Colors.orange, 'Bank & Cards'),
          _buildSettingsItem(Icons.receipt_long_outlined, Colors.red, 'Transaction'),
          _buildSettingsItem(Icons.settings_outlined, Colors.blue, 'Settings'),
          _buildSettingsItem(Icons.privacy_tip_outlined, Colors.green, 'Data Privacy', showDivider: false),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, Color iconColor, String title, {Widget? trailing, bool showDivider = true}) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: Colors.grey[200],
            indent: 20,
            endIndent: 20,
          ),
      ],
    );
  }
}