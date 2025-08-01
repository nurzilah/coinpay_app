import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddingCardFlow extends StatefulWidget {
  @override
  _AddingCardFlowState createState() => _AddingCardFlowState();
}

class _AddingCardFlowState extends State<AddingCardFlow> {
  PageController _pageController = PageController();
  int currentPage = 0;

  // Form controllers
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();

  // Sample card data
  List<Map<String, dynamic>> cardList = [
    {
      'type': 'Account',
      'number': '•••••••••••• 3984', 
      'color': Colors.orange,
      'icon': 'mastercard'
    },
    {
      'type': 'Account',
      'number': '•••••••••••• 5678',
      'color': Colors.orange,
      'icon': 'mastercard'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          children: [
            _buildIntroScreen(),
            _buildAddCardScreen(),
            _buildVerifyCardScreen(),
            _buildCardListScreen(),
            _buildCardListDetailScreen(),
          ],
        ),
      ),
    );
  }

  // Screen 1: Introduction Screen
  Widget _buildIntroScreen() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildAppBar(showBack: false),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Illustration
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.credit_card,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Let's add your card",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Experience the power of financial organization\nwith our platform",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          _buildButton(
            text: "+ Add your card",
            onPressed: () => _nextPage(),
          ),
        ],
      ),
    );
  }

  // Screen 2: Add Card Form
  Widget _buildAddCardScreen() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildAppBar(title: "Add card"),
          SizedBox(height: 20),
          Text(
            "Please add card info and bank details",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputLabel("Account Holder Name"),
                _buildTextField(
                  controller: accountHolderController,
                  hintText: "Full Name",
                ),
                SizedBox(height: 20),
                _buildInputLabel("Email"),
                _buildTextField(
                  controller: emailController,
                  hintText: "example@yourcompany.com",
                ),
                SizedBox(height: 20),
                _buildInputLabel("Card Number"),
                _buildTextField(
                  controller: cardNumberController,
                  hintText: "0000 0000 0000 0000",
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/Mastercard.svg',
                    width: 32,
                    height: 20,
                  ),
                ),
                Spacer(),
                _buildButton(
                  text: "Verify",
                  onPressed: () => _nextPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Screen 3: Verify Card
  Widget _buildVerifyCardScreen() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildAppBar(title: "Verify your card"),
          SizedBox(height: 20),
          Text(
            "We send 6 digits code to yourname@example.com",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Column(
              children: [
                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) => _buildOTPField()),
                ),
                SizedBox(height: 32),
                Text(
                  "Didn't get a code? Resend",
                  style: TextStyle(
                    color: Color(0xFF304FFE),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Spacer(),
                _buildButton(
                  text: "Verify",
                  onPressed: () => _nextPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Screen 4: Card List
  Widget _buildCardListScreen() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildAppBar(title: "Card list"),
          SizedBox(height: 20),
          Text(
            "See your saved card here from live banking",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                ...cardList.map((card) => _buildCardItem(card)).toList(),
                Spacer(),
                _buildButton(
                  text: "Add another card",
                  onPressed: () => _goToPage(1),
                  outlined: true,
                ),
                SizedBox(height: 12),
                _buildButton(
                  text: "Continue",
                  onPressed: () => _nextPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Screen 5: Card List Detail
  Widget _buildCardListDetailScreen() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildAppBar(title: "Card list"),
          SizedBox(height: 20),
          Text(
            "See your saved card here from live banking",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                ...cardList.map((card) => _buildCardItem(card, showDelete: true)).toList(),
                Spacer(),
                _buildButton(
                  text: "Add another card",
                  onPressed: () => _goToPage(1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildAppBar({String? title, bool showBack = true}) {
    return Row(
      children: [
        if (showBack)
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
            onPressed: () => _previousPage(),
          ),
        if (title != null) ...[
          SizedBox(width: showBack ? 0 : 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontFamily: 'Poppins',
            ),
          ),
        ],
        Spacer(),
        Icon(Icons.more_horiz, color: Colors.grey[400]),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontFamily: 'Poppins',
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: suffixIcon != null 
          ? Padding(
              padding: EdgeInsets.all(12),
              child: suffixIcon,
            )
          : null,
        prefixIcon: prefixIcon != null 
          ? Padding(
              padding: EdgeInsets.all(12),
              child: prefixIcon,
            )
          : null,
      ),
      style: TextStyle(fontFamily: 'Poppins'),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    bool outlined = false,
    bool enabled = true,
  }) {
    return SizedBox(
      width: double.infinity, // Lebar penuh
      height: 54, // Tinggi 54 piksel
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: outlined 
            ? Colors.white 
            : (enabled ? Color(0xFF304FFE) : Colors.grey.shade300), // Biru solid untuk Sign up, putih untuk Login
          foregroundColor: outlined 
            ? Color(0xFF304FFE) 
            : (enabled ? Colors.white : Colors.grey.shade600), // Teks biru untuk outline, putih untuk solid
          elevation: 0,
          side: outlined ? BorderSide(color: Color(0xFF304FFE)) : null, // Border biru untuk Login
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27), // Radius 27 untuk tampilan oval
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16, // Ukuran font 16
            fontWeight: FontWeight.w600, // Ketebalan semi-bold
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem(Map<String, dynamic> card, {bool showDelete = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: card['color'],
              borderRadius: BorderRadius.circular(8),
            ),
            child: card['icon'] == 'mastercard' 
              ? Padding(
                  padding: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/icons/Mastercard.svg',
                    width: 24,
                    height: 24,
                  ),
                )
              : Icon(
                  card['icon'],
                  color: Colors.white,
                  size: 20,
                ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['type'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  card['number'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          if (showDelete)
            Icon(Icons.delete_outline, color: Colors.red, size: 20),
        ],
      ),
    );
  }

  // Helper method for OTP input field
  Widget _buildOTPField() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
  void _nextPage() {
    if (currentPage < 4) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    accountHolderController.dispose();
    emailController.dispose();
    cardNumberController.dispose();
    super.dispose();
  }
}