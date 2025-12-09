import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  // จำลองการ Login ไปยัง Shibboleth / Microsoft
  Future<void> _handleSSOLogin() async {
    setState(() {
      _isLoading = true;
    });

    // ในการใช้งานจริง ตรงนี้จะใช้ flutter_appauth หรือ url_launcher
    // เพื่อ redirect ไปยัง Shibboleth IdP URL ของคุณ
    // ตัวอย่าง: https://idp.your-university.ac.th/idp/profile/SAML2/Redirect/SSO
    
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Redirecting to Shibboleth IdP (Microsoft Login)...'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Placeholder
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.school, // Icon แทนสถาบัน/องค์กร
                  size: 50,
                  color: Color(0xFF0078D4),
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                'Organization Login',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in with your institutional account',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),

              // Login Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Authentication Required',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      
                      // Microsoft / SSO Button
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _handleSSOLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F2F2F), // Dark background for contrast
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: _isLoading 
                            ? const SizedBox(
                                width: 20, 
                                height: 20, 
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                              )
                            : const Icon(Icons.login), // Normally Microsoft Logo
                        label: const Text(
                          'Sign in with Microsoft (SSO)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Secondary Option (if needed)
                      OutlinedButton(
                        onPressed: () {
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Local login not implemented in this demo')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Guest Access'),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              Text(
                'Powered by Shibboleth IdP',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
