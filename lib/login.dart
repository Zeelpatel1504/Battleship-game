import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'gamelist.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final String baseUrl = 'http://165.227.117.48';  // Your API base URL
  bool isLoading = false;  // To prevent multiple submissions

  // Register User
  Future<void> registerUser(BuildContext context) async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both username and password')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    // Log the response body for debugging
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Registration successful: ${data['message']}');
      print('Access Token: ${data['access_token']}');
      saveTokenLocally(data['access_token']);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User registered successfully')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameList(
            username: usernameController.text,
            accessToken: data['access_token'],
          ),
        ),
      );
    } else if (response.statusCode == 400) {
      final data = jsonDecode(response.body);
      print('Registration failed. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Check if the 'message' or 'error' key exists in the response
      if (data.containsKey('message')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${data['message']}')),
        );
      } else if (data.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${data['error']}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unknown error occurred')),
        );
      }
    } else {
      print('Registration failed. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed. Please try again')),
      );
    }
  }

  // Login User
  Future<void> loginUser(BuildContext context) async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both username and password')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    // Log the response body for debugging
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Login successful: ${data['message']}');
      print('Access Token: ${data['access_token']}');
      saveTokenLocally(data['access_token']);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in successfully')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameList(
            username: usernameController.text,
            accessToken: data['access_token'],
          ),
        ),
      );
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    } else {
      print('Login failed. Status Code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again')),
      );
    }
  }

  // Save the token locally
  void saveTokenLocally(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sessionToken', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isWideScreen = constraints.maxWidth > 600;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  isWideScreen
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: isLoading ? null : () => loginUser(context),
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Login'),
                            ),
                            ElevatedButton(
                              onPressed: isLoading ? null : () => registerUser(context),
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Register'),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            ElevatedButton(
                              onPressed: isLoading ? null : () => loginUser(context),
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Login'),
                            ),
                            const SizedBox(height: 8.0),
                            ElevatedButton(
                              onPressed: isLoading ? null : () => registerUser(context),
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Register'),
                            ),
                          ],
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
