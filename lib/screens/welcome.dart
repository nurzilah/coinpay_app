import 'package:coinpay_app/screens/home.dart';
import 'package:coinpay_app/screens/login.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Illustration/Image
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background illustration frame
                        Container(
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // Person icon
                        Positioned(
                          left: 80,
                          top: 60,
                          child: Container(
                            width: 60,
                            height: 80,
                            child: Stack(
                              children: [
                                // Head
                                Positioned(
                                  left: 20,
                                  top: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                // Body
                                Positioned(
                                  left: 15,
                                  top: 20,
                                  child: Container(
                                    width: 30,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                // Arms
                                Positioned(
                                  left: 5,
                                  top: 25,
                                  child: Container(
                                    width: 50,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Celebration elements
                        Positioned(
                          right: 40,
                          top: 40,
                          child: Icon(
                            Icons.star,
                            color: Colors.blue[300],
                            size: 16,
                          ),
                        ),
                        Positioned(
                          left: 40,
                          top: 80,
                          child: Icon(
                            Icons.circle,
                            color: Colors.orange[300],
                            size: 12,
                          ),
                        ),
                        Positioned(
                          right: 60,
                          bottom: 60,
                          child: Icon(
                            Icons.stars,
                            color: Colors.purple[300],
                            size: 20,
                          ),
                        ),
                        // Plant/flower at bottom
                        Positioned(
                          bottom: 30,
                          right: 80,
                          child: Container(
                            width: 40,
                            height: 60,
                            child: Stack(
                              children: [
                                // Stem
                                Positioned(
                                  left: 18,
                                  bottom: 0,
                                  child: Container(
                                    width: 4,
                                    height: 40,
                                    color: Colors.green[400],
                                  ),
                                ),
                                // Flower
                                Positioned(
                                  left: 10,
                                  top: 0,
                                  child: Icon(
                                    Icons.local_florist,
                                    color: Colors.blue[400],
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Title
                  const Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Subtitle
                  const Text(
                    'Welcome to Coinpay',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Description
                  const Text(
                    'We are happy to have you. It\'s time to send, receive\nand track your expense.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to PIN setup or next screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF304FFE),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Progress indicator (optional)
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}