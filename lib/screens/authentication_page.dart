import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:oppolia_online/constants/ApiKeys.dart';
import 'package:oppolia_online/screens/main_page.dart';
import 'package:oppolia_online/constants/theme_constants.dart';

// Providers for managing phone number, OTP, and API status
final phoneProvider = StateProvider<String>((ref) => '+966'); // Start with +966
final otpProvider = StateProvider<String>((ref) => '');
final otpSentProvider = StateProvider<bool>((ref) => false);

// API Service provider
final apiProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  final Dio _dio = Dio();

  String generateOtp() => (100000 + Random().nextInt(900000)).toString();

  Future<void> sendOtpSms(String phone) async {
    final otp = generateOtp();
    final message = "Your verification code is: $otp";
    print(message);

    final url =
        "${MoraApiConstants.sendSmsEndpoint}?api_key=${MoraApiConstants.apiKey}&username=${MoraApiConstants.username}";

    try {
      final response = await _dio.post(
        url,
        data: {
          "message": message,
          "sender": MoraApiConstants.senderName,
          "numbers": phone,
        },
      );

      if (response.statusCode == 200) {
        print("OTP sent successfully: ${response.data}");
      } else {
        print("Failed to send OTP: ${response.data}, $phone");
      }
      print(response.data);
    } catch (e) {
      throw Exception("Failed to send OTP: $e");
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    try {
      final response = await _dio.post(
        "${MoraApiConstants.sendSmsEndpoint}/verify",
        data: {"phone": phone, "otp": otp},
      );

      if (response.statusCode == 200) {
        print("OTP verified successfully: ${response.data}");
      } else {
        throw Exception("Failed to verify OTP: ${response.data}");
      }
    } catch (e) {
      throw Exception("Failed to verify OTP: $e");
    }
  }
}

class AuthPage extends ConsumerStatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  Future<void> _sendOtp() async {
    final phone = ref.read(phoneProvider);
    ref.read(otpSentProvider.notifier).state = true;

    try {
      await ref.read(apiProvider).sendOtpSms(phone);
    } catch (e) {
      _showError(context, 'Failed to send OTP. Please try again.');
    }
  }

  Future<void> _verifyOtp() async {
    final phone = ref.read(phoneProvider);
    final otp = ref.read(otpProvider);

    try {
      await ref.read(apiProvider).verifyOtp(phone, otp);
      _showSuccess(context, 'OTP Verified Successfully!');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    } catch (e) {
      _showError(context, 'Invalid OTP. Please try again.');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    final otpSent = ref.watch(otpSentProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/home-page-banner.webp',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/Oppolia-logo-website.png',
                      width: 225,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: otpSent
                    ? Column(
                        key: ValueKey('OTPFields'),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: ThemeConstants.primaryColor),
                              onPressed: () => ref
                                  .read(otpSentProvider.notifier)
                                  .state = false,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return SizedBox(
                                width: 40,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: '*',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: ThemeConstants.primaryColor,
                                          width: 2),
                                    ),
                                  ),
                                  onChanged: (value) => ref
                                      .read(otpProvider.notifier)
                                      .state += value,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: _verifyOtp,
                              child: const Text('Verify',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        key: ValueKey('PhoneField'),
                        children: [
                          Container(
                            width: 250,
                            child: TextField(
                              controller: TextEditingController.fromValue(
                                TextEditingValue(
                                  text: ref.read(phoneProvider),
                                  selection: TextSelection.collapsed(
                                    offset: ref.read(phoneProvider).length,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (!value.startsWith('+966')) {
                                  ref.read(phoneProvider.notifier).state =
                                      '+966$value';
                                } else {
                                  ref.read(phoneProvider.notifier).state =
                                      value;
                                }
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                    color: ThemeConstants.primaryColor),
                                prefixIcon: Icon(Icons.phone,
                                    color: ThemeConstants.primaryColor),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: ThemeConstants.primaryColor,
                                      width: 2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: _sendOtp,
                              child: const Text('Send',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
