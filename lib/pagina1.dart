import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({Key? key}) : super(key: key);

  @override
  _Pagina1State createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  Map? _userData;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Facebook (Logged ' +
                (_userData == null ? 'Out' : 'In') +
                ')')),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  child: const Text('Log In'),
                  onPressed: () async {
                    final result = await FacebookAuth.i
                        .login(permissions: ["public_profile", "email"]);

                    if (result.status == LoginStatus.success) {
                      final userData = await FacebookAuth.i.getUserData(
                        fields: "email,name",
                      );

                      setState(() {
                        _userData = userData;
                      });
                    }
                  }),
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
      ),
    );
  }
}
