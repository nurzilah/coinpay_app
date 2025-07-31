import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coinpay_app/constants/color.dart';
import 'package:coinpay_app/screens/home.dart';
import 'package:coinpay_app/screens/qris.dart';
import 'package:coinpay_app/screens/support.dart';
import 'package:coinpay_app/screens/profile.dart';
import 'package:simple_icons/simple_icons.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({Key? key}) : super(key: key);

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  String selectedMonth = 'January';
  
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<Map<String, dynamic>> spendingData = [
    {
      'date': '2-8',
      'spent': 800.0,
      'income': 0.0,
    },
    {
      'date': '9-15',
      'spent': 0.0,
      'income': 600.0,
    },
    {
      'date': '16-22',
      'spent': 900.0,
      'income': 0.0,
    },
    {
      'date': '23-29',
      'spent': 0.0,
      'income': 400.0,
    },
    {
      'date': '30-1',
      'spent': 500.0,
      'income': 0.0,
    },
  ];

  final List<Map<String, dynamic>> transactions = [
    {
      'name': 'Netflix',
      'date': '1st Jan at 7:20pm',
      'amount': -15.99,
      'icon': SimpleIcons.netflix,
      'color': Colors.red,
    },
    {
      'name': 'Google',
      'date': '1st Jan at 6:15pm',
      'amount': -100.0,
      'icon': SimpleIcons.google,
      'color': Colors.blue,
    },
  ];

  final List<Map<String, dynamic>> categoryData = [
    {
      'name': 'Spending',
      'icon': Icons.credit_card,
      'color': Color(0xFF4F7DF9),
    },
    {
      'name': 'Income',
      'icon': Icons.trending_up,
      'color': Color(0xFF00C896),
    },
    {
      'name': 'Bills',
      'icon': Icons.receipt_long,
      'color': Color(0xFFFFC107),
    },
    {
      'name': 'Savings',
      'icon': Icons.savings,
      'color': Color(0xFFFF9800),
    },
  ];

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
        title: Text(
          'Spending',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Selector
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedMonth,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: months.map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF4F7DF9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Spend',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$500.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available Balance',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$20,000.00',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 32),
            
            // Chart
            Container(
              height: 200,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: spendingData.map((data) {
                        double maxHeight = 120;
                        double spentHeight = (data['spent'] / 1000) * maxHeight;
                        double incomeHeight = (data['income'] / 1000) * maxHeight;
                        
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (data['spent'] > 0)
                              Container(
                                width: 24,
                                height: spentHeight,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4F7DF9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            if (data['income'] > 0)
                              Container(
                                width: 24,
                                height: incomeHeight,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFC107),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            SizedBox(height: 8),
                            Text(
                              data['date'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            // Category Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categoryData.map((category) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        category['icon'],
                        color: category['color'],
                        size: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      category['name'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            
            SizedBox(height: 32),
            
            // Spending List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spending list',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.more_horiz,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Transaction List
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: transaction['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          transaction['icon'],
                          color: transaction['color'],
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              transaction['date'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${transaction['amount'].abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: transaction['amount'] < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            SizedBox(height: 100), // Bottom padding for navigation
          ],
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          boxShadow: [
            BoxShadow(
              color: AppColors.contentPrimary.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, 'assets/icons/home.svg', 'Home', isActive: false),
            _buildNavItem(context, 'assets/icons/chart-pie.svg', 'Spending', isActive: true),
            _buildNavItem(context, 'assets/icons/scanner.svg', 'QR', isActive: false, isCenter: true),
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
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 'Spending':
        // Already on spending screen
        break;
      case 'QR':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => QrisScreen()),
        );
        break;
      case 'Support':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SupportScreen()),
        );
        break;
      case 'Profile':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }
}