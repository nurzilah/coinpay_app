import 'package:coinpay_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coinpay_app/screens/spending.dart';
import 'package:coinpay_app/screens/qris.dart';
import 'package:coinpay_app/screens/support.dart';
import 'package:coinpay_app/screens/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/trophy-star.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      AppColors.contentOnColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.contentOnColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: AppColors.contentOnColor.withValues(alpha: 0.7), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Search "Payments"',
                            style: TextStyle(color: AppColors.contentOnColor.withValues(alpha: 0.7), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SvgPicture.asset(
                    'assets/icons/bell.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      AppColors.contentOnColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('💰', style: TextStyle(fontSize: 12)),
                            SizedBox(width: 4),
                            Text(
                              'US Dollar',
                              style: TextStyle(
                                color: AppColors.contentOnColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        '\$20,000',
                        style: TextStyle(
                          color: AppColors.contentOnColor,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Available Balance',
                        style: TextStyle(
                          color: AppColors.contentOnColor.withValues(alpha: 0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.bgLight,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/wallet.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Add Money',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickAction(context, Icons.send, 'Send', AppColors.primary),
                  _buildQuickAction(context, Icons.request_page, 'Request', AppColors.warning),
                  _buildQuickAction(context, Icons.account_balance, 'Bank', AppColors.warning),
                ],
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bgLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.contentPrimary,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: AppColors.contentTertiary,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildTransactionItem(
                            iconPath: 'assets/icons/credit-card-minus.svg',
                            iconColor: Color(0xFF4F7DF9),
                            title: 'Spending',
                            amount: '-\$500',
                            amountColor: AppColors.error,
                          ),
                          _buildTransactionItem(
                            iconPath: 'assets/icons/coins.svg',
                            iconColor: Color(0xFF00C896),
                            title: 'Income',
                            amount: '\$3000',
                            amountColor: AppColors.success,
                          ),
                          _buildTransactionItem(
                            iconPath: 'assets/icons/invoice.svg',
                            iconColor: Color(0xFFFFC107),
                            title: 'Bills',
                            amount: '-\$800',
                            amountColor: AppColors.error,
                          ),
                          _buildTransactionItem(
                            iconPath: 'assets/icons/sack-dollar.svg',
                            iconColor: Color(0xFFFF9800),
                            title: 'Savings',
                            amount: '\$1000',
                            amountColor: AppColors.warning,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          boxShadow: [
            BoxShadow(
              color: AppColors.contentPrimary.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, 'assets/icons/home-2.svg', 'Home', isActive: true),
            _buildNavItem(context, 'assets/icons/chart-pie.svg', 'Spending', isActive: false),
            _buildNavItem(context, 'assets/icons/scanner.svg', 'QR', isActive: false, isCenter: true),
            _buildNavItem(context, 'assets/icons/chat.svg', 'Support', isActive: false),
            _buildNavItem(context, 'assets/icons/user.svg', 'Profile', isActive: false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String iconPath, String label, {required bool isActive, bool isCenter = false}) {
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
                  padding: EdgeInsets.all(8),
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
                SizedBox(height: 4),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.bgLight,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.contentPrimary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: AppColors.contentOnColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem({required String iconPath, required Color iconColor, required String title, required String amount, required Color amountColor}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.contentPrimary,
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: amountColor,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.keyboard_arrow_right, size: 20, color: AppColors.contentDisabled),
        ],
      ),
    );
  }

  void _handleNavTap(BuildContext context, String navItem) {
    switch (navItem) {
      case 'Home':
        break;
      case 'Spending':
        Navigator.push(context, MaterialPageRoute(builder: (context) => SpendingScreen()));
        break;
      case 'QR':
        Navigator.push(context, MaterialPageRoute(builder: (context) => QrisScreen()));
        break;
      case 'Support':
        Navigator.push(context, MaterialPageRoute(builder: (context) => SupportScreen()));
        break;
      case 'Profile':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
    }
  }
}