import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coinpay_app/constants/color.dart';
import 'package:coinpay_app/screens/home.dart';
import 'package:coinpay_app/screens/spending.dart';
import 'package:coinpay_app/screens/support.dart';
import 'package:coinpay_app/screens/profile.dart';

class QrisScreen extends StatelessWidget {
  const QrisScreen({super.key});

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
          'Select a Purpose',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Profile section
            CircleAvatar(
              radius: 40,
              backgroundImage: const AssetImage('assets/images/pp_linkedin.jpg'),
              onBackgroundImageError: (exception, stackTrace) {},
              child: const AssetImage('assets/images/pp_linkedin.jpg') != null 
                ? null 
                : const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Nurzilah Hidayati',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'nurzilah.hyt@gmail.com',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            // Amount input
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Text(
                    '500',
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Amount to Send',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Continue button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to confirmation page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
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
            _buildNavItem(context, 'assets/icons/scanner.svg', 'QR', isActive: true, isCenter: true),
            _buildNavItem(context, 'assets/icons/chat.svg', 'Support', isActive: false),
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
        // Already on QR screen
        break;
      case 'Support':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SupportScreen()),
        );
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