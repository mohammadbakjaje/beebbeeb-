import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Screens/Driver/register_driver/bloc_register/register_cubit_driver.dart';
import 'package:untitled1/Screens/Driver/register_driver/bloc_register/register_state_driver.dart';
import 'package:untitled1/Screens/Layout/layout_screen.dart';
import '../../helper/my_colors.dart';
import '../../widget/coustem_buton.dart';
import '../../widget/coustem_text_filed.dart';
import '../Drawer/ theme_provider.dart';
import 'driver.dart';

class DriverRegisterPage extends StatelessWidget {
  @override
  static String id = "DriverRegisterPage";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      appBar: AppBar(
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
        backgroundColor:
            themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(23),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Driver Account",
                  style: TextStyle(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black,
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
                        child: BlocConsumer<DriverRegisterCubit,
                            DriverRegisterState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: TextFormField(
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
                                        fontSize: 16,
                                      ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              context
                                                      .read<
                                                          DriverRegisterCubit>()
                                                      .obscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<
                                                          DriverRegisterCubit>(
                                                      context)
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
                                    obscureText: context
                                        .read<DriverRegisterCubit>()
                                        .obscure,
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
                                    fillColor: themeProvider.isDarkMode
                                        ? MyColors.dark_2
                                        : Colors.grey[200],
                                    filled: true,
                                    hintStyle: TextStyle(
                                      color: themeProvider.isDarkMode
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.black.withOpacity(0.5),
                                      fontSize: 16,
                                    ),
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
                                            context
                                                    .read<DriverRegisterCubit>()
                                                    .obscureConfirm
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          onPressed: () {
                                            BlocProvider.of<
                                                        DriverRegisterCubit>(
                                                    context)
                                                .changeConfirmPasswordState();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: themeProvider.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                  obscureText: context
                                      .read<DriverRegisterCubit>()
                                      .obscureConfirm,
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 40.0),
                                  child: (state is DriverRegisterLoadingState)
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : CoustemButon(
                                          text: "Continue",
                                          ontap: () {
                                            if (!formkey.currentState!
                                                .validate()) {
                                              // إذا فشل التحقق، توقف عن التنفيذ
                                              return;
                                            }

                                            // إذا نجح التحقق، قم بتنفيذ الإجراءات
                                            context
                                                .read<DriverRegisterCubit>()
                                                .registerBloc(
                                                  firstNameController.text,
                                                  lastNameController.text,
                                                  phoneNumberController.text,
                                                  passwordController.text,
                                                  passwordConfirmationController
                                                      .text,
                                                );
                                          },
                                        ),
                                ),
                              ],
                            );
                          },
                          listener: (BuildContext context,
                              DriverRegisterState state) {
                            if (state is DriverRegisterErrorState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(state.errorMsg),
                              ));
                            }
                            if (state is DriverRegisterSuccessState) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Driver(),
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
                      style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
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
        ),
      ),
    );
  }
}
