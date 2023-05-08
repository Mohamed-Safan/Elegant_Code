import 'package:apphotel/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginWithFacebook() async {
    _isLoading = true;

    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        // Logged in successfully, access token received
        print('Logged in successfully! User ID: ${accessToken.userId}');
      } else {
        // Handle Facebook login failure
        print('Facebook login failed. Status: ${result.status}');
      }
    } catch (e) {
      // Handle Facebook login exception
      print('Facebook login exception: $e');
    }

    _isLoading = false;
  }

  void _navigateToHomePage(BuildContext context) {
    // Navigate to the home page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bcg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email TextField
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Password TextField
              TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  _navigateToHomePage(context);
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              // Login with Facebook Button
              ElevatedButton(
                onPressed: _isLoading ? null : _loginWithFacebook,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Login with Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
