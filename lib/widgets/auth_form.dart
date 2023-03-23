import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  //const AuthForm({super.key});

  AuthForm(this.submitFn);

  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
  ) submitFn; // 아무것도 반환하지 않는 함수

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate(); // add !
    FocusScope.of(context).unfocus(); // 양식 제출할 때 키보드 닫히게..?

    if (isValid) {
      _formKey.currentState!.save; // add !
      widget.submitFn(_userEmail, _userPassword, _userName, _isLogin);

      // Use those values to send out auth request ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // 필요한 만큼만 늘어난다
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        // add !
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _userPassword = value!; // add !
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          // add !
                          return 'Password enter at least 4 characters.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value!; // add !
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        // add !
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true, // 사용자가 입력한 텍스트 숨기기
                    onSaved: (value) {
                      _userPassword = value!; // add !
                    },
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    // RaisedButton -> ElevatedButton
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'), // 윗줄이랑 위치 변경
                  ),
                  TextButton(
                    // FlatButton -> TextButton
                    style: TextButton.styleFrom(
                      //primary: Theme.of(context).primaryColor, // 글자색
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
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
