// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ited_study_app_admin/core/constants/boxsize.dart';
import 'package:ited_study_app_admin/core/constants/style.dart';
import 'package:ited_study_app_admin/core/route/routes.dart';
import 'package:ited_study_app_admin/core/widgets/form_field.dart';
import 'package:ited_study_app_admin/feature/auth/presentation/providers/login_provider.dart';

class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);
    ref.listen(
      loginNotifierProvider,
      (previous, next) async {
        if (next.status == LoginStatus.success) {
          final snackBar = SnackBar(
            content: Text(next.message ?? 'Login Success'),
          );
          ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
              snackBarController =
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

          await snackBarController.closed;

          context.pushReplacement(AdminRoutes.dashboard);
        } else if (next.status == LoginStatus.error) {
          final snackbar = SnackBar(
            content: Text(next.error ?? "login failed"),
          );
          ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
              snackBarController =
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
          snackBarController.close;
        }
      },
    );
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 16, 147, 1),
                  Color.fromRGBO(0, 5, 45, 1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 200,
                        top: 80,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Let's rebuild together.....",
                        style: CustomStyle.loginStyle,
                      ),
                    ),
                  ],
                ),
                CustomBoxSize.extraLarge,
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 80),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 390,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(189, 193, 200, 0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Positioned(
                        left: 80,
                        top: -200,
                        child: Container(
                          height: 590,
                          width: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/person.png"),
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -50,
                                top: 180,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rebranding the futures of',
                                        style: CustomStyle.loginStyle,
                                      ),
                                      Text(
                                        "our time again",
                                        style: CustomStyle.loginStyle,
                                      ),
                                      CustomBoxSize.extra,
                                      Text(
                                        "ITed",
                                        style: CustomStyle.nameStyle,
                                      ),
                                      Image.asset(
                                        "assets/images/EDUCATIONAL.jpg",
                                        height: 50,
                                        width: 300,
                                      ),
                                      Text(
                                        "Software",
                                        style: CustomStyle.nameStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CustomBoxSize.tiny,
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Let's rebuild together.....",
                      style: CustomStyle.loginStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: 700,
                width: 600,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(189, 193, 200, 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/admin.png"),
                      Text(
                        "LOGIN",
                        style: CustomStyle.login,
                      ),
                      Text(
                        "Enter your details to login",
                        style: CustomStyle.login2,
                      ),
                      CustomBoxSize.big,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomFormField(
                              label: 'Username',
                              obscure: false,
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Username',
                            ),
                            CustomBoxSize.medium,
                            CustomFormField(
                              label: 'Password',
                              obscure: true,
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              hintText: 'Password',
                            ),
                          ],
                        ),
                      ),
                      CustomBoxSize.big,
                      loginState.status == LoginStatus.loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InkWell(
                              onTap: () {
                                ref.read(loginNotifierProvider.notifier).login(
                                      _usernameController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(0, 16, 147, 1),
                                      Color.fromRGBO(0, 5, 45, 1),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: CustomStyle.loginStyle,
                                  ),
                                ),
                              ),
                            ),
                      CustomBoxSize.big,
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
