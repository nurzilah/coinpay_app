import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'profile.dart';

class AccountVerificationFlow extends StatefulWidget {
  const AccountVerificationFlow({super.key});

  @override
  State<AccountVerificationFlow> createState() => _AccountVerificationFlowState();
}

class _AccountVerificationFlowState extends State<AccountVerificationFlow>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  
  // Animation controllers
  AnimationController? _progressController;
  AnimationController? _checkmarkController;
  
  // Camera controllers
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;
  
  // Verification states
  bool phoneVerified = true;
  bool documentVerified = false;
  bool photoVerified = false;
  bool isDocumentScanning = false;
  bool isPhotoTaking = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _checkmarkController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
    } catch (e) {
      debugPrint('Error initializing cameras: $e');
    }
  }

  Future<void> _initializeCamera({bool isRearCamera = true}) async {
    if (_cameras == null || _cameras!.isEmpty) return;
    
    try {
      // Select camera (rear for document, front for selfie)
      CameraDescription selectedCamera;
      if (isRearCamera) {
        selectedCamera = _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
          orElse: () => _cameras!.first,
        );
      } else {
        selectedCamera = _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => _cameras!.first,
        );
      }

      _cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile picture = await _cameraController!.takePicture();
      
      // You can save the picture or process it here
      debugPrint('Picture taken: ${picture.path}');
      
      // Simulate processing delay
      await Future.delayed(Duration(seconds: 1));
      
      if (_currentStep == 2) {
        // Document verification completed
        setState(() {
          documentVerified = true;
          isDocumentScanning = false;
        });
        _disposeCamera();
        _nextStep();
      } else if (_currentStep == 4) {
        // Photo verification completed
        setState(() {
          photoVerified = true;
          isPhotoTaking = false;
        });
        _disposeCamera();
        
        // FIX: Add mounted check before navigation
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        }
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      
      await _cameraController!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
    } catch (e) {
      debugPrint('Error toggling flash: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;
    
    await _disposeCamera();
    
    // Switch between front and rear camera
    bool useRearCamera = _currentStep == 2; // Document scan uses rear camera
    await _initializeCamera(isRearCamera: !useRearCamera);
  }

  Future<void> _disposeCamera() async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
      _cameraController = null;
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  @override
  void dispose() {
    _progressController?.dispose();
    _checkmarkController?.dispose();
    _pageController.dispose();
    _disposeCamera();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 4) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      // Dispose camera when going back from camera screens
      if (_currentStep == 2 || _currentStep == 4) {
        _disposeCamera();
      }
      
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBackgroundColor(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: _getAppBarIconColor(),
          ),
          onPressed: () {
            if (_currentStep == 0) {
              Navigator.pop(context);
            } else {
              _previousStep();
            }
          },
        ),
        centerTitle: true,
        title: _getAppBarTitle(),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // Step 0: Setting up account
          _buildSetupAccountPage(),
          // Step 1: Scan ID document intro
          _buildScanDocumentIntroPage(),
          // Step 2: Scan ID document camera
          _buildScanDocumentCameraPage(),
          // Step 3: Take selfie intro
          _buildTakeSelfieIntroPage(),
          // Step 4: Take selfie camera
          _buildTakeSelfieCameraPage(),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    if (_currentStep == 2 || _currentStep == 4) {
      return Colors.black;
    }
    return Colors.white;
  }

  Color _getAppBarIconColor() {
    if (_currentStep == 2 || _currentStep == 4) {
      return Colors.white;
    }
    return Colors.black;
  }

  Widget? _getAppBarTitle() {
    if (_currentStep == 2) {
      return Text(
        '1/2',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );
    } else if (_currentStep == 4) {
      return Text(
        '2/2',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    return null;
  }

  // Step 0: Setting up your account
  Widget _buildSetupAccountPage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Progress bar
          Container(
            height: 4,
            margin: EdgeInsets.only(bottom: 40),
            child: LinearProgressIndicator(
              value: 0.2,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF304FFE)),
            ),
          ),
          
          Spacer(),
          
          // Illustration
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Phone illustration
                Container(
                  width: 120,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person, color: Colors.white, size: 24),
                      ),
                      SizedBox(height: 20),
                      Container(height: 2, width: 60, color: Colors.grey[300]),
                      SizedBox(height: 8),
                      Container(height: 2, width: 40, color: Colors.grey[300]),
                    ],
                  ),
                ),
                
                // Decorative elements
                Positioned(
                  left: -20,
                  top: 50,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFF304FFE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.settings, color: Colors.white, size: 16),
                  ),
                ),
                
                Positioned(
                  right: 20,
                  top: 30,
                  child: Icon(Icons.attach_money, color: Colors.orange, size: 20),
                ),
                
                Positioned(
                  left: 10,
                  bottom: 40,
                  child: Icon(Icons.credit_card, color: Color(0xFF304FFE), size: 20),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 60),
          
          // Title
          Text(
            'Setting up\nyour account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          
          SizedBox(height: 16),
          
          // Subtitle
          Text(
            'We need to verify your identity to secure your account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          
          SizedBox(height: 40),
          
          // Verification steps
          Column(
            children: [
              _buildVerificationStep(
                number: '1',
                title: 'Phone verified',
                isCompleted: phoneVerified,
              ),
              SizedBox(height: 16),
              _buildVerificationStep(
                number: '2',
                title: 'Document verification',
                isCompleted: documentVerified,
                isLoading: isDocumentScanning,
              ),
              SizedBox(height: 16),
              _buildVerificationStep(
                number: '3',
                title: 'Photo verification',
                isCompleted: photoVerified,
                isLoading: isPhotoTaking,
              ),
            ],
          ),
          
          Spacer(),
          
          // Continue button
          GestureDetector(
            onTap: _nextStep,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xFF304FFE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Continue Verification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildVerificationStep({
    required String number,
    required String title,
    required bool isCompleted,
    bool isLoading = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isCompleted ? Color(0xFF304FFE) : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF304FFE)),
                      ),
                    )
                  : Text(
                      isCompleted ? '✓' : number,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Spacer(),
          if (isCompleted)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xFF304FFE),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 14),
            ),
        ],
      ),
    );
  }

  // Step 1: Scan ID document intro
  Widget _buildScanDocumentIntroPage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Progress bar
          Container(
            height: 4,
            margin: EdgeInsets.only(bottom: 40),
            child: LinearProgressIndicator(
              value: 0.4,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF304FFE)),
            ),
          ),
          
          Spacer(),
          
          // ID Card illustration
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.orange[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(height: 4, color: Colors.grey[400]),
                              SizedBox(height: 4),
                              Container(height: 4, width: 60, color: Colors.grey[400]),
                              SizedBox(height: 4),
                              Container(height: 4, width: 40, color: Colors.grey[400]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Scan icon
                Positioned(
                  top: 0,
                  right: 40,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFF304FFE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.document_scanner, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 60),
          
          // Title
          Text(
            'Scan ID document to\nverify your identity',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          
          SizedBox(height: 16),
          
          // Subtitle
          Text(
            'Take a clear photo of your government-issued ID\ncard to verify your identity.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          
          Spacer(),
          
          // Scan ID button
          GestureDetector(
            onTap: () {
              setState(() {
                isDocumentScanning = true;
              });
              _initializeCamera(isRearCamera: true);
              _nextStep();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xFF304FFE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.document_scanner, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Scan ID Document',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Step 2: Scan ID document camera (1/2)
  Widget _buildScanDocumentCameraPage() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Full screen camera preview
          Positioned.fill(
            child: _isCameraInitialized && _cameraController != null
                ? CameraPreview(_cameraController!)
                : Container(
                    color: Colors.grey[900],
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF304FFE),
                      ),
                    ),
                  ),
          ),
          
          // Top overlay with title
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Please scan front\nof your ID card',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // ID Card scanning frame overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              painter: DocumentScanOverlayPainter(),
            ),
          ),
          
          // Instructions
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Position your ID card within the frame\nand tap to capture',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.4,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Camera controls
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Flash button
                GestureDetector(
                  onTap: _toggleFlash,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                // Capture button
                GestureDetector(
                  onTap: _isCameraInitialized ? _takePicture : null,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _isCameraInitialized ? Colors.white : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!, width: 4),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: _isCameraInitialized ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ),
                
                // FIXED: Line 848 - Replace Container with SizedBox for whitespace
                SizedBox(
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step 3: Take selfie intro
  Widget _buildTakeSelfieIntroPage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Progress bar
          Container(
            height: 4,
            margin: EdgeInsets.only(bottom: 40),
            child: LinearProgressIndicator(
              value: 0.8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF304FFE)),
            ),
          ),
          
          Spacer(),
          
          // Selfie illustration
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Camera frame
                Container(
                  width: 120,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                
                // Person illustration
                SizedBox(
                  width: 80,
                  height: 100,
                  child: Column(
                    children: [
                      // Head
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.orange[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Body
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Camera icon
                Positioned(
                  top: 0,
                  right: 20,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF304FFE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 60),
          
          // Title
          Text(
            'Take selfie to verify\nyour identity',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          
          SizedBox(height: 16),
          
          // Subtitle
          Text(
            'Quick and easy identification verification using\nyour phone\'s camera. Confirm your identity with a\nself-captured photo.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          
          Spacer(),
          
          // Take a selfie button
          GestureDetector(
            onTap: () {
              setState(() {
                isPhotoTaking = true;
              });
              _initializeCamera(isRearCamera: false);
              _nextStep();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xFF304FFE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Take a selfie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // FIXED: Line 864 (originally at end of method) - Replace Container with SizedBox for whitespace
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Step 4: Take selfie camera
  Widget _buildTakeSelfieCameraPage() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Camera preview
          Positioned.fill(
            child: _isCameraInitialized && _cameraController != null
                ? CameraPreview(_cameraController!)
                : Container(
                    color: Colors.grey[900],
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF304FFE),
                      ),
                    ),
                  ),
          ),
          
          // Oval overlay
          Positioned.fill(
            child: CustomPaint(
              painter: OvalOverlayPainter(),
            ),
          ),
          
          // Instructions
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Text(
              'Take your photo at arms length.\nMake sure your whole face is visible.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
          
          // Camera controls
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Flash button
                GestureDetector(
                  onTap: _toggleFlash,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                // Capture button
                GestureDetector(
                  onTap: _isCameraInitialized ? _takePicture : null,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _isCameraInitialized ? Colors.white : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!, width: 4),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: _isCameraInitialized ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ),
                
                // Switch camera button
                GestureDetector(
                  onTap: _switchCamera,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.cameraswitch, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for document scan overlay
class DocumentScanOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create rectangular cutout for ID card (landscape orientation)
    double frameWidth = size.width * 0.8;
    double frameHeight = frameWidth * 0.6; // ID card ratio
    double frameLeft = (size.width - frameWidth) / 2;
    double frameTop = (size.height - frameHeight) / 2;

    Path framePath = Path();
    framePath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(frameLeft, frameTop, frameWidth, frameHeight),
      Radius.circular(12),
    ));

    path = Path.combine(PathOperation.difference, path, framePath);
    canvas.drawPath(path, paint);

    // Draw frame border with corner brackets
    Paint borderPaint = Paint()
      ..color = Color(0xFF304FFE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Corner bracket length
    double bracketLength = 30;

    // Top-left corner
    canvas.drawLine(
      Offset(frameLeft, frameTop + bracketLength),
      Offset(frameLeft, frameTop),
      borderPaint,
    );
    canvas.drawLine(
      Offset(frameLeft, frameTop),
      Offset(frameLeft + bracketLength, frameTop),
      borderPaint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(frameLeft + frameWidth - bracketLength, frameTop),
      Offset(frameLeft + frameWidth, frameTop),
      borderPaint,
    );
    canvas.drawLine(
      Offset(frameLeft + frameWidth, frameTop),
      Offset(frameLeft + frameWidth, frameTop + bracketLength),
      borderPaint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(frameLeft, frameTop + frameHeight - bracketLength),
      Offset(frameLeft, frameTop + frameHeight),
      borderPaint,
    );
    canvas.drawLine(
      Offset(frameLeft, frameTop + frameHeight),
      Offset(frameLeft + bracketLength, frameTop + frameHeight),
      borderPaint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(frameLeft + frameWidth - bracketLength, frameTop + frameHeight),
      Offset(frameLeft + frameWidth, frameTop + frameHeight),
      borderPaint,
    );
    canvas.drawLine(
      Offset(frameLeft + frameWidth, frameTop + frameHeight),
      Offset(frameLeft + frameWidth, frameTop + frameHeight - bracketLength),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for oval overlay
class OvalOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create oval cutout
    double ovalWidth = size.width * 0.7;
    double ovalHeight = size.height * 0.5;
    double ovalLeft = (size.width - ovalWidth) / 2;
    double ovalTop = (size.height - ovalHeight) / 2 - 50;

    Path ovalPath = Path();
    ovalPath.addOval(Rect.fromLTWH(ovalLeft, ovalTop, ovalWidth, ovalHeight));

    path = Path.combine(PathOperation.difference, path, ovalPath);
    canvas.drawPath(path, paint);

    // Draw oval border
    Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawOval(Rect.fromLTWH(ovalLeft, ovalTop, ovalWidth, ovalHeight), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}