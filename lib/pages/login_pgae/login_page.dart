import 'package:flutter/material.dart';
import 'package:portal/services/services.dart';
import 'package:portal/pages/pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.onSubmit,
    required this.cpyid,
    //required this.cpy1,
  });
  final ValueChanged<String> onSubmit;
  final String cpyid;
  //final String cpy1;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Future idandtokens;

  @override
  void dispose() {
    userEmailController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();

    passwordVisible = true;
  }

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      widget.onSubmit(userEmailController.value.text);
      widget.onSubmit(userPasswordController.value.text);
      setState(() {
        idandtokens =
            createAlbum(widget.cpyid, "test12345@gmail.com", "test@123");
        // userEmailController.text,
        // userPasswordController.text);
      });
      var r = await idandtokens;
      // print(
      //     "----------------------------------------------------------------------------");
      // print(r);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Shipments(
                    iddata: r,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 84, 42),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 234, 237, 235),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: Checkbox.width),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: userEmailController,
                          onChanged: (val) {
                            _formKey.currentState?.validate();
                            setState(() {});
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintText: 'Enter email',
                              suffixIcon: userEmailController.text.length > 0
                                  ? IconButton(
                                      onPressed: () {
                                        userEmailController.clear();
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.cancel_rounded))
                                  : null,
                              prefixIcon: Icon(Icons.mail)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }

                            // if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            //   return "Please enter a valid email address";
                            // }

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            obscureText: passwordVisible,
                            controller: userPasswordController,
                            onChanged: (val) {
                              _formKey.currentState?.validate();
                              setState(() {});
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintText: 'password',
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else {
                                // if (!RegExp(
                                //         r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                //     .hasMatch(value)) {
                                //   return 'Enter valid password';
                                // } else {
                                //   return null;
                                // }
                              }
                            }),
                      ),
                      ElevatedButton(
                        onPressed: userEmailController.value.text.isNotEmpty &&
                                userPasswordController.value.text.isNotEmpty
                            ? _submit
                            : null,
                        child: Text('Sign in'),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
