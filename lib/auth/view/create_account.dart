import 'package:amazon_clone/auth/services/firebase_auth_service.dart';
import 'package:amazon_clone/utils/loader.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:amazon_clone/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../utils/snackbar.dart';
import '../view_model/auth_view_model.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  FirebaseAuthService authService = FirebaseAuthService();
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
    // final authProvider = Provider.of<AuthViewModel>(context);
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
                'Create Account',
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
              Consumer<AuthViewModel>(
                builder: (context, authProvider, child) =>
                    authProvider.isLoading
                        ? const CustomButtonLoader(color: Colors.amber)
                        : CustomButton(
                            text: 'Create Account',
                            onTap: () async {
                              await authProvider.signUp(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                                context,
                              );
                              _emailController.clear();
                              _passwordController.clear();
                            },
                            color: AppColors.secondaryColor,
                          ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text('or create account with google sign-in?'),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<AuthViewModel>(
                builder: (context, provider, child) => CustomButton(
                    text: provider.isLoading ? 'Loading...' : 'Google-Sign-In',
                    onTap: () async {
                      await authService.googleSignIn(context);
                      // await provider.signInWithGoogle(context);
                    },
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
