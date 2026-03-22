import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Matching the beige background from the project theme
      backgroundColor: const Color(0xFFF1EDE8), 
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircularButton(Icons.arrow_back, () => Navigator.pop(context)),
                  _buildCircularButton(Icons.settings_outlined, () {}),
                ],
              ),
            ),

            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Header Image with Fade
                        Stack(
                          children: [
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Image.asset(
                                'assets/images/crowd.jpg', // Reusing the project asset
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.5, 1.0],
                                    colors: [Colors.transparent, Colors.white],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              const Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A2130),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Join Evently and start exploring.',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(height: 25),

                              // Form Fields
                              _buildField('FULL NAME', 'Enter your full name'),
                              const SizedBox(height: 15),
                              _buildField('EMAIL OR PHONE', 'Enter your email or phone'),
                              const SizedBox(height: 15),
                              _buildField(
                                'PASSWORD', 
                                'Create a password',
                                isPassword: true,
                              ),
                              
                              const SizedBox(height: 30),

                              // Sign Up Button
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF9E8576),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Create Account',
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),
                              const Text('OR SIGN UP WITH',
                                  style: TextStyle(color: Colors.black12, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 20),

                              // Social Options
                              Row(
                                children: [
                                  Expanded(child: _buildSocialBtn('Google', 'assets/images/google.png')),
                                  const SizedBox(width: 15),
                                  Expanded(child: _buildSocialBtn('Apple', null, icon: Icons.apple)),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text("Log In",
                        style: TextStyle(color: Color(0xFFC68E74), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // UI Helpers to maintain consistency
  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.grey, size: 20),
      ),
    );
  }

  Widget _buildField(String label, String hint, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
        TextField(
          obscureText: isPassword && !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFB0C0D0), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFFBFBFB),
            suffixIcon: isPassword 
                ? IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey, size: 20),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ) 
                : null,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Colors.grey.shade100)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Color(0xFFC68E74))),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(String label, String? asset, {IconData? icon}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colors.grey.shade100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (asset != null) Image.asset(asset, height: 18) else Icon(icon, color: Colors.black, size: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}