import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/widget/login_form.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      switch (sizingInformation.deviceScreenType) {
        case DeviceScreenType.mobile:
        case DeviceScreenType.tablet:
          return MobileLoginScreen(
            controller: _controller,
            passwordController: _passWordController,
          );
        case DeviceScreenType.desktop:
        case DeviceScreenType.watch:
        default:
          return DesktopLoginScreen(
            controller: _controller,
            passwordController: _passWordController,
          );
      }
    });
  }
}

class MobileLoginScreen extends StatelessWidget {
  final TextEditingController? controller;
  final TextEditingController? passwordController;

  const MobileLoginScreen({
    Key? key,
    this.controller,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/houlala.png"),
                        fit: BoxFit.contain)),
              ),
            ),
            standardVerticalSpace,
            LoginForm(
              controller: controller,
              passwordController: passwordController,
              width: MediaQuery.of(context).size.width * 0.6,
            )
          ],
        ),
      ),
    );
  }
}

class DesktopLoginScreen extends StatelessWidget {
  final TextEditingController? controller;
  final TextEditingController? passwordController;

  const DesktopLoginScreen({
    Key? key,
    this.controller,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/houlala.png"),
                      fit: BoxFit.contain)),
            ),
          ),
          Expanded(
            child: LoginForm(
              width: MediaQuery.of(context).size.width *  0.3,
              controller: controller,
              passwordController: passwordController,
            ),
          )
        ],
      ),
    );
  }
}
