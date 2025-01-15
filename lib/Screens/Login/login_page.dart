import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Screens/HomePage/HomePage.dart';
import 'package:untitled1/Screens/Layout/layout_screen.dart';
import 'package:untitled1/Screens/register/register_page.dart';
import 'package:untitled1/Screens/reset_page.dart';
import 'package:untitled1/helper/my_colors.dart';
import 'package:untitled1/widget/coustem_buton.dart';
import 'package:untitled1/widget/coustem_text_filed.dart';

import '../../helper/constants.dart';
import '../Drawer/ theme_provider.dart';
import '../Driver/login_page_driver.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static String id = "LoginPage";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      appBar: AppBar(
        backgroundColor:
            themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 460, left: 75),
            child: Image.asset(
              "images/Group 11 (1).png",
              height: 400,
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(23),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign in",
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        CoustemTextFormFiled(
                          textInputType: TextInputType.phone,
                          controller: emailController,
                          hintText: "Phone Number",
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please Enter Your Number';
                            } else if ((value ?? '').length != 10) {
                              return 'Must be 10 number';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        BlocConsumer<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return TextFormField(
                              decoration: InputDecoration(
                                hintText: "Password",
                                fillColor: themeProvider.isDarkMode
                                    ? MyColors.dark_2
                                    : Colors.grey[200],
                                filled: true,
                                hintStyle: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? Colors.white.withOpacity(0.5)
                                        : Colors.black.withOpacity(0.5),
                                    fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: themeProvider.isDarkMode
                                        ? MyColors.dark_2
                                        : Colors.grey[200]!,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeProvider.isDarkMode
                                          ? MyColors.dark_2
                                          : Colors.grey[200]!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.buttun),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.buttun),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                  letterSpacing: 1,
                                ),
                                suffixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        context.read<LoginCubit>().obscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: themeProvider.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<LoginCubit>(context)
                                            .changePasswordState();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                              obscureText: context.read<LoginCubit>().obscure,
                              obscuringCharacter: '*',
                              validator: (value) {
                                if ((value ?? '').isEmpty) {
                                  return 'Please enter your password';
                                } else if (value!.length < 8) {
                                  return 'your password must be at least 8 charchters';
                                } else {
                                  return null;
                                }
                              },
                              controller: passwordController,
                            );
                          },
                          listener: (context, state) {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Forget Password ? ",
                              style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ResetPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Reset",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: GestureDetector(
                            child: BlocConsumer<LoginCubit, LoginState>(
                              builder:
                                  (BuildContext context, LoginState state) {
                                if (state is LoginLoadingState) {
                                  return CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                } else {
                                  return CoustemButon(
                                    text: "Continue",
                                    ontap: () {
                                      if (formkey.currentState!.validate()) {
                                        context.read<LoginCubit>().loginBloc(
                                            emailController.text,
                                            passwordController.text);
                                      }
                                    },
                                  );
                                }
                              },
                              listener:
                                  (BuildContext context, LoginState state) {
                                if (state is LoginErrorState) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(state.errorMsg),
                                  ));
                                }
                                if (state is LoginSuccessState) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LayoutScreen(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ? ",
                              style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterPage.id);
                              },
                              child: Text(
                                "Create One",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Are you a driver? ",
                              style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(DriverLoginPage.id);
                              },
                              child: Text(
                                "Driver Account ?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
