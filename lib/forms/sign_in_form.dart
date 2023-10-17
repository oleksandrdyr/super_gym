import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gym/block/block.dart';
import 'package:flutter_gym/models/users.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    print('build page');
    bool isCheckedFrm = true;
    TextEditingController loginController = TextEditingController();
    loginController.text =
        context.read<DataCubitChat>().getUserEmail; // 'vasia@mail.ru';
    TextEditingController passController = TextEditingController();
    passController.text =
        context.read<DataCubitChat>().getPassword; //'7777pass999';
    // bool IsRemember = true;
    // TextEditingController displayNameController = TextEditingController();
    // displayNameController.text = '';
    // Crud.getParam('Remember').then((String value) {
    //   print('Remember from block = $value');
    //   if (value == 'T') {
    //     Crud.getParam('NameUser').then((String value) {
    //       loginController.text = value;
    //     });
    //     Crud.getParam('Password').then((String value) {
    //       passController.text = value;
    //     });
    //     context.read<DataCubitChat>().setRememberMe(true);
    //   }
    // });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Fire Chat',
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DataCubitChat, KeeperChat>(builder: (context, state) {
        return

            //  Center(
            //   child: Text(
            //     'Sign In',
            //     style: txt30,
            //   ),

            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: loginController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid mail id as abc@gmail.com'),
                onChanged: (value) {
                  context.read<DataCubitChat>().setUserEmail(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your secure password'),
                onChanged: (value) {
                  context.read<DataCubitChat>().setPassword(value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 16,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        'Sign In',
                      ),
                      onPressed: () async {
                        print(
                            'Login: ${loginController.text}, Password: ${passController.text}');

                        try {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: loginController.text,
                                  password: passController.text)
                              .then((value) async {
                            if (value.user == null) {
                              print('SighIn  Error');

                              showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Warning!'),
                                  content: const Text(
                                      'Login And Pass not correctly!'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              print(value);

                              // String loginValue = loginController.text;
                              // String passwordValue = passController.text;
                              // String rememberValue = isCheckedFrm ? 'T' : 'F';

                              // await Crud.updParam('NameUser', loginValue);
                              // await Crud.updParam('Password', passwordValue);
                              // await Crud.updParam('Remember', rememberValue);

                              Navigator.pushNamed(context, '/ChatForms');
                            }
                          });
                        } catch (e) {
                          print(e);
                          showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Warning!'),
                              content: Text(e.toString()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            // CheckboxWidget(callback: (value) => isCheckedFrm = value),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Register');
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
          //  );
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    print('initState');
  }
}
