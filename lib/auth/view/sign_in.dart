import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custombutton.dart';
import '../view_model/auth_view_model.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.appBarGradient,
            ),
          ),
          title: const Text(
            'Amazon.in',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sign in with your account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Enter email address',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _emailController,
                hintText: 'Enter your email',
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter password here',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Enter your password',
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  text:provider.isLoading?'Loading...': 'Sign-in',
                  onTap: () {

                    provider.signIn(_emailController.text.trim(), _passwordController.text.trim(), context);
                  },

                  color: AppColors.secondaryColor),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text('or sign in with your google account?'),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: 'Google-Sign-In', onTap: () {
                    provider.signInWithGoogle(context);
              }, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
