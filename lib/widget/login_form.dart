import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/model/login_model.dart';
import 'package:houlalaadministrator/service/login_service.dart';
import 'package:houlalaadministrator/widget/custom_elevated_button.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController? controller;
  final TextEditingController? passwordController;
  final double? width;

  final passWordRex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{6,}$');

  LoginForm({
    Key? key,
    this.controller,
    this.passwordController,
    this.width,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.width,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  label: Text("Email"), border: OutlineInputBorder()),
              validator: (value) {
                value = widget.controller!.text;
                if (value.isEmpty) {
                  return 'Inserer une adresse E-mail';
                } else if (!value.contains('@')) {
                  return 'Svp entrer une E-mail valide';
                }
                return null;
              },
            ),
          ),
          standardVerticalSpace,
          SizedBox(
            width: widget.width,
            child: TextFormField(
              controller: widget.passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                  label: Text("Mot De passe"), border: OutlineInputBorder()),
              validator: (value) {
                value = widget.passwordController!.text;
                if (value.isEmpty) {
                  return 'Inserer un Mot de passe';
                }
                if (!widget.passWordRex.hasMatch(value)) {
                  return 'Mot de passe invalide';
                }
                return null;
              },
            ),
          ),
          standardVerticalSpace,
          SizedBox(
            width: widget.width,
            child: InkWell(
              onTap: () {},
              child:
                  const Text("Mot de passe oublie? / Probleme de Connextion?"),
            ),
          ),
          standardVerticalSpace,
          InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                LoginModel login = LoginModel(
                    email: widget.controller!.text,
                    password: widget.passwordController!.text);

                await Provider.of<LoginService>(context, listen: false)
                    .logIn(login);

                if (!mounted) return;

                Navigator.of(context).pushNamed("/dashboard");
              }
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0)),
              child: const Text("Se Connecter"),
            ),
          )
        ],
      ),
    );
  }
}
