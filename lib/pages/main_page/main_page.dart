import 'package:flutter/material.dart';
import 'package:portal/pages/pages.dart';
import 'package:portal/services/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _formKey = GlobalKey<FormState>();
  final cpyController = TextEditingController();

  void dispose() {
    cpyController.dispose();
    super.dispose();
  }

  _submit(cpyn) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      String returnid = await getRequest(cpyn);
      if (returnid != 'null') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => LoginPage(
                      cpyid: returnid,
                      onSubmit: (value) {},
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50,
            child: Center(
              child: Text(
                "No matching company found",
                style: TextStyle(fontWeight: FontWeight.w900),
                //textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
          ),
        ));
      }
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
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome',
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 50)),
                SizedBox(
                  height: 60,
                ),
                TextFormField(
                  controller: cpyController,
                  onChanged: (val) {
                    _formKey.currentState?.validate();
                    setState(() {});
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      hintText: 'username',
                      prefixIcon: Icon(Icons.mail),
                      suffixIcon: cpyController.text.length > 0
                          ? IconButton(
                              onPressed: () {
                                cpyController.clear();
                                setState(() {});
                              },
                              icon: Icon(Icons.cancel_rounded))
                          : null),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    if (!RegExp(r'\S+[a-z]\S+').hasMatch(value)) {
                      return "Please enter a valid username";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      String cpyname = "jio";
                      _submit(cpyname);
                    },
                    child: Text(
                      'Submit',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
