import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:ronda/components/password_field.dart';
import 'package:ronda/components/text_form_builder.dart';
import 'package:ronda/utils/validation.dart';
import 'package:ronda/viewModel/auth/registervm.dart';
import 'package:ronda/widgets/indicators.dart';
//import 'package:ronda/components/radio_button.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String> options = [
    'employee',
    'employer',
  ];
  List<int> options_index = [1, 2];
  int value = 0;

  @override
  void initState() {
    // TODO: implement initState
    value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //int value;
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
    return LoadingOverlay(
      progressIndicator: circularProgress(context),
      isLoading: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Text(
              'Welcome to Ronda \n Start griding now ',
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 30.0),
            buildForm(viewModel, context),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account  ',
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildForm(RegisterViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.person_outline,
            hintText: "Username",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setName(val);
            },
            focusNode: viewModel.usernameFN,
            nextFocusNode: viewModel.emailFN,
          ),
          const SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.mail_outline,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.countryFN,
          ),
          SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.pin_outline,
            hintText: "Country",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setCountry(val);
            },
            focusNode: viewModel.countryFN,
            nextFocusNode: viewModel.passFN,
          ),
          const SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_closed_outline,
            suffix: Ionicons.eye_outline,
            hintText: "Password",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validatePassword,
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
            nextFocusNode: viewModel.cPassFN,
          ),
          SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_open_outline,
            hintText: "Confirm Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.register(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setConfirmPass(val);
            },
            focusNode: viewModel.cPassFN,
          ),
          const SizedBox(height: 20.0),
          Row(children: <Widget>[
            CustomRadioButton(context, options[0], 1),
            const SizedBox(
              width: 10,
            ),
            CustomRadioButton(context, options[1], 2),
            //viewModel.setRole(value)
          ]),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            height: 45.0,
            width: 180.0,
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary),
                ),
                child: Text(
                  'sign up'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  viewModel.setRole(value);
                  viewModel.register(context);
                }),
          ),
        ],
      ),
    );
  }

  Widget CustomRadioButton(BuildContext contex, String text, int index) {
    return FilledButton.tonal(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.secondary),
        minimumSize: MaterialStateProperty.all(Size(130, 40)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          value = index;
          print(value);
        });
      },
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: (value == index)
              ? Color.fromARGB(255, 89, 188, 93)
              : Colors.black,
        ),
      ),
    );
  }
}
