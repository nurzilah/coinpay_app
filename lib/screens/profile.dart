import 'package:coinpay_app/screens/account_setup.dart';
import 'package:coinpay_app/screens/account_verif.dart';
import 'package:coinpay_app/screens/adding_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coinpay_app/screens/home.dart';
import 'package:coinpay_app/screens/spending.dart';
import 'package:coinpay_app/screens/qris.dart';
import 'package:coinpay_app/screens/support.dart';
import 'package:coinpay_app/constants/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.contentPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Profile', style: TextStyle(fontFamily: 'Poppins', color: AppColors.contentPrimary)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined, color: AppColors.contentPrimary, size: 20),
            onPressed: () {
              // Handle edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Header
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 4),
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
                      border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/pp_linkedin.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFF3F4F6),
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Color(0xFF9CA3AF),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nurzilah Hidayati',
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'nurzilah.hyt@gmail.com',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    '+6285712799296',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Settings Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    'assets/icons/moon.svg', 
                    const Color(0xFF6B7280), 
                    'Dark Mode',
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isDarkMode,
                        onChanged: (value) => setState(() => isDarkMode = value),
                        activeColor: const Color(0xFF3B82F6),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    onTap: null, // Dark mode tidak perlu navigasi
                  ),
                  _buildSettingsItem(
                    'assets/icons/user-2.svg', 
                    const Color(0xFF3B82F6), 
                    'Personal Info',
                    onTap: () => _navigateToPersonalInfo(context),
                  ),
                  _buildSettingsItem(
                    'assets/icons/bank.svg', 
                    const Color(0xFFF59E0B), 
                    'Bank & Cards',
                    onTap: () => _navigateToBankCards(context),
                  ),
                  _buildSettingsItem(
                    'assets/icons/credit-card-change.svg', 
                    const Color(0xFFEF4444), 
                    'Transaction',
                    onTap: () => _navigateToTransaction(context),
                  ),
                  _buildSettingsItem(
                    'assets/icons/settings.svg', 
                    const Color(0xFF3B82F6), 
                    'Settings',
                    onTap: () => _navigateToSettings(context),
                  ),
                  _buildSettingsItem(
                    'assets/icons/database.svg', 
                    const Color(0xFF10B981), 
                    'Data Privacy', 
                    showDivider: false,
                    onTap: () => _navigateToDataPrivacy(context),
                  ),
                ],
              ),
            ),
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
              color: AppColors.contentPrimary.withValues(alpha: 0.1),
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
            _buildNavItem(context, 'assets/icons/user-2.svg', 'Profile', isActive: true),
          ],
        ),
      ),
    );
  }

  // Navigation methods untuk settings items
  void _navigateToPersonalInfo(BuildContext context) {
    // Sementara menggunakan placeholder page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountSetupScreen(),
      ),
    );
    
    // Uncomment ini setelah file personal_info.dart dibuat
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const PersonalInfoScreen()),
    // );
  }

  void _navigateToBankCards(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddingCardFlow(),
      ),
    );
    
    // Uncomment ini setelah file bank_cards.dart dibuat
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const BankCardsScreen()),
    // );
  }

  void _navigateToTransaction(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _buildPlaceholderPage('Transaction'),
      ),
    );
    
    // Uncomment ini setelah file transaction.dart dibuat
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const TransactionScreen()),
    // );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountVerificationFlow(),
      ),
    );
    
    // Uncomment ini setelah file settings.dart dibuat
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SettingsScreen()),
    // );
  }

  void _navigateToDataPrivacy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _buildPlaceholderPage('Data Privacy'),
      ),
    );
    
    // Uncomment ini setelah file data_privacy.dart dibuat
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const DataPrivacyScreen()),
    // );
  }

  // Placeholder page sementara
  Widget _buildPlaceholderPage(String title) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.contentPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title, 
          style: TextStyle(fontFamily: 'Poppins', color: AppColors.contentPrimary)
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: AppColors.contentTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              '$title Page',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coming Soon...',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
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

  Widget _buildSettingsItem(
    String iconPath, 
    Color iconColor, 
    String title, {
    Widget? trailing, 
    bool showDivider = true,
    VoidCallback? onTap, // Tambahan parameter untuk handle tap
  }) {
    return Column(
      children: [
        GestureDetector( // Tambahkan GestureDetector untuk handle tap
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      width: 22,
                      height: 22,
                      colorFilter: ColorFilter.mode(
                        iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                trailing ?? const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(
            margin: const EdgeInsets.only(left: 80),
            height: 1,
            color: const Color(0xFFF3F4F6),
          ),
      ],
    );
  }
}
