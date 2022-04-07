import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({Key? key}) : super(key: key);

  @override
  _Pagina1State createState() => _Pagina1State();
}

var foto = '';

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class _Pagina1State extends State<Pagina1> {
  Map? _userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook'),
        centerTitle: true,
        actions: [
          _userData == null
              ? const Text('')
              : SizedBox(width: 30, height: 30, child: Image.network(foto)),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            ElevatedButton(
                child: const Text('Log In'),
                onPressed: () async {
                  final result = await FacebookAuth.i
                      .login(permissions: ["public_profile", "email"]);
                  if (result.status == LoginStatus.success) {
                    final userData = await FacebookAuth.i.getUserData(
                      fields: "name,email,picture.width(50)",
                    );
                    setState(() {
                      _userData = userData;
                      foto = (_userData!['picture']['data']['url']);
                    });
                  }
                }),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                child: const Text('Log Out'),
                onPressed: () async {
                  await FacebookAuth.i.logOut();

                  setState(() {
                    _userData = null;
                  });
                }),
          ],
        ),
      ),
    );
  }
}

/*

                      log(_userData!['name']);
                      log(_userData!['email']);
                      log(_userData!['picture']['data']['url']);
                      log('Foto $foto');
                      log(_userData.toString());
                      prettyPrint(_userData!);

*/