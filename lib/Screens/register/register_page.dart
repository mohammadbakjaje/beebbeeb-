import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import 'package:untitled1/Screens/Layout/layout_screen.dart';
import 'package:untitled1/Screens/register/bloc/register_cubit.dart';
import 'package:untitled1/Screens/register/bloc/register_states.dart';

import '../../helper/my_colors.dart';
import '../../widget/coustem_buton.dart';
import '../../widget/coustem_text_filed.dart';
import '../Drawer/ theme_provider.dart';
import '../HomePage/HomePage.dart';

class RegisterPage extends StatelessWidget {
  @override
  static String id = "RegisterPage";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
  TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white, // تغيير لون الخلفية
      appBar: AppBar(
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black, // تغيير لون النص
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white, // تغيير لون AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(23),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black, // تغيير لون النص
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CoustemTextFormFiled(
                              hintText: "FirstName",
                              controller: firstNameController,
                              validator: (value) {
                                if ((value ?? '').isEmpty) {
                                  return 'Enter Your FirstName';
                                } else if ((value ?? '').length < 2) {
                                  return 'At least 2 character';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CoustemTextFormFiled(
                              controller: lastNameController,
                              hintText: "LastName",
                              validator: (value) {
                                if ((value ?? '').isEmpty) {
                                  return 'Enter Your LastName';
                                } else if ((value ?? '').length < 2) {
                                  return 'At least 2 character';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 16),
                        child: CoustemTextFormFiled(
                          textInputType: TextInputType.phone,
                          hintText: "Phone Number",
                          controller: phoneNumberController,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please Enter Your PhoneNumber';
                            } else if ((value ?? '').length != 10) {
                              return 'must be 10 Numbers';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: BlocConsumer<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      fillColor: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200], // تغيير لون الخلفية
                                      filled: true,
                                      hintStyle: TextStyle(
                                        color: themeProvider.isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5), // تغيير لون النص
                                        fontSize: 16,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                          color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200]!, // تغيير لون الحدود
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200]!), // تغيير لون الحدود
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: MyColors.buttun),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: MyColors.buttun),
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
                                              context.read<RegisterCubit>().obscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: themeProvider.isDarkMode ? Colors.white : Colors.black, // تغيير لون الأيقونة
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<RegisterCubit>(context)
                                                  .changePasswordState();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // تغيير لون النص
                                    obscureText: context.read<RegisterCubit>().obscure,
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
                                  ),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "ConfirmPassword",
                                    fillColor: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200], // تغيير لون الخلفية
                                    filled: true,
                                    hintStyle: TextStyle(
                                      color: themeProvider.isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5), // تغيير لون النص
                                      fontSize: 16,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200]!, // تغيير لون الحدود
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200]!), // تغيير لون الحدود
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyColors.buttun),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyColors.buttun),
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
                                            context.read<RegisterCubit>().obscureConfirm
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: themeProvider.isDarkMode ? Colors.white : Colors.black, // تغيير لون الأيقونة
                                          ),
                                          onPressed: () {
                                            BlocProvider.of<RegisterCubit>(context)
                                                .changeConfirmPasswordState();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // تغيير لون النص
                                  obscureText: context.read<RegisterCubit>().obscureConfirm,
                                  obscuringCharacter: '*',
                                  validator: (value) {
                                    if ((value ?? '').isEmpty) {
                                      return 'Please enter your confirmation password';
                                    } else if (value!.length < 8) {
                                      return 'your password must be at least 8 charchters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: passwordConfirmationController,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                                  child: (state is RegisterLoadingState)
                                      ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                      : CoustemButon(
                                    text: "Continue",
                                    ontap: () {
                                      if (formkey.currentState!.validate()) {
                                        context.read<RegisterCubit>().registerBloc(
                                          firstNameController.text,
                                          lastNameController.text,
                                          phoneNumberController.text,
                                          passwordController.text,
                                          passwordConfirmationController.text,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          listener: (BuildContext context, RegisterState state) {
                            if (state is RegisterErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.errorMsg),
                              ));
                            }
                            if (state is RegisterSuccessState) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LayoutScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "You have an account ? ",
                      style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // تغيير لون النص
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black, // تغيير لون النص
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}