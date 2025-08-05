import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'otp_screen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<CreateAccount> {
  final TextEditingController passwordController = TextEditingController();
  String completePhone = '';
  bool isPasswordFilled = false;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      setState(() {
        isPasswordFilled = passwordController.text.isNotEmpty;
      });
    });
  }

  void showPhoneVerificationPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified_user, size: 60, color: Color(0xFF304FFE)),
              const SizedBox(height: 16),
              const Text(
                "Verify your phone number\nbefore we send code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Is this correct?\n$completePhone',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              // Updated popup button styling
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // tutup popup
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtpScreen(phone: completePhone)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF304FFE),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("No", style: TextStyle(fontFamily: 'Poppins')),
              ),
            ],
          ),
        );
      },
    );
  }

  void handleLogin() {
    if (passwordController.text == '123456') {
      showPhoneVerificationPopup();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password salah. Gunakan 123456')),
      );
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your registered mobile number to Sign up.',
                style: TextStyle(fontSize: 14, fontFamily: 'Poppins', color: Colors.black54),
              ),
              const SizedBox(height: 32),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                initialCountryCode: 'ID',
                onChanged: (phone) => completePhone = phone.completeNumber,
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 20),
              const Text('Password', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              TextField(
                controller: passwordController,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  hintText: '', // hint dikosongkan
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password?', style: TextStyle(fontFamily: 'Poppins', color: Colors.blue)),
                ),
              ),
              const SizedBox(height: 16),
              // Updated main button styling
              SizedBox(
                width: double.infinity, // Lebar penuh
                height: 54, // Tinggi 54 piksel
                child: ElevatedButton(
                  onPressed: isPasswordFilled ? handleLogin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPasswordFilled ? Color(0xFF304FFE) : Colors.grey.shade300, // Biru solid saat aktif, abu-abu saat nonaktif
                    foregroundColor: isPasswordFilled ? Colors.white : Colors.grey.shade600, // Teks putih saat aktif, abu-abu saat nonaktif
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27), // Radius 27 untuk tampilan oval
                    ),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16, // Ukuran font 16
                      fontWeight: FontWeight.w600, // Ketebalan semi-bold
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}