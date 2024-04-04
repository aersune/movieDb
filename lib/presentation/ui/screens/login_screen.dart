import 'package:flutter/material.dart';
import 'package:movie_db/domain/models/auth_model.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    return Scaffold(
      backgroundColor: const Color(0xff1a191f),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(width: MediaQuery.of(context).size.width, child: Image.asset('assets/logo.jpg')),
            const SizedBox(height: 35),
            Text(
              'Hello Again!',
              style: GoogleFonts.dancingScript(
                fontSize: 60,
                color: AppColors.whiteColor,
                letterSpacing: 2,
              ),
            ),
            Text(
              'welcome back, you\'ve beem missed!',
              style: GoogleFonts.dancingScript(
                fontSize: 25,
                color: AppColors.whiteColor,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 50),
            const _ErrorMessageWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: model?.loginController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'username',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: model?.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const _AuthButtonWidget(),
            const SizedBox(height: 25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Not a member?   ',
                  style: TextStyle(fontSize: 15, color: AppColors.whiteColor),
                ),
                Text(
                  'Register now',
                  style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 25),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    final onPressed = model?.canStartAuth == true  ?  () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true ? const SizedBox(
      height: 27,
        width: 27,
        child:  CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.whiteColor,)) :const Text(
      'Sign in',
      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => model?.auth(context),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: AppColors.lightColor, borderRadius: BorderRadius.circular(12)),
          child:  Center(
              child: child
          ),
        ),
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
    if(errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        errorMessage,
        style: const TextStyle(fontSize: 17, color: AppColors.lightColor),
      ),
    );
  }
}

