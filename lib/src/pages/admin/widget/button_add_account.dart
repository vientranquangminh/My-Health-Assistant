import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

import '../../../widgets/buttons/my_elevated_button.dart';

class ButtonAddAccountDoctor extends StatefulWidget {
  const ButtonAddAccountDoctor({
    Key? key,
  }) : super(key: key);

  @override
  State<ButtonAddAccountDoctor> createState() => _ButtonAddAccountDoctorState();
}

class _ButtonAddAccountDoctorState extends State<ButtonAddAccountDoctor> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _departmentController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  title: SizedBox(
                    child: Column(
                      children: const [
                        Text(
                          'Add Account Doctor',
                          // 'Cancel Appointment Success',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  content: SizedBox(
                    height: 330,
                    child: Column(
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: "Name",
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter doctor name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _departmentController,
                          decoration: InputDecoration(
                              hintText: "Department",
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter doctor department';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter doctor email address';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          // controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(
                                Icons.email,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter doctor password';
                            } else if (value.length < 8) {
                              return "Length of password's characters must be 8 or greater";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: MyElevatedButton(
                          buttonColor: Colors.blue,
                          customFunction: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          fontSize: 16,
                          text: 'Submit',
                          textColor: Colors.white,
                        ))
                  ],
                ),
              ),
            );
          },
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.lightBlue,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_add,
                    color: MyColors.mainColor,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Add New Account Doctor',
                    style: MyFontStyles.mainColorH4,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
