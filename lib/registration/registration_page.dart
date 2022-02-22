import 'package:flutter/material.dart';
import 'package:registration_remake/model/user.dart';
import 'package:registration_remake/registration/user_info_page.dart';

// ignore_for_file: prefer_const_constructors
// ignore: avoid_print/**/
// ignore_for_file: avoid_print

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _accountType = [
    'Management',
    'Business',
    'Company',
    'Guest',
    'Student'
  ];
  String? _selectedAccount;

//для пароля visibility
  bool _hidePass = true;

  final _accountController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  //---
  final _accountFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmPassFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    //Очищяем контроллер после удаления виджета
    _accountController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _accountFocus.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    _confirmPassFocus.dispose();
    super.dispose();
  }

  //метод который позволяет переводить фокусы
  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(

          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              SizedBox(height: 40),
              topPage(),
              SizedBox(height: 40),
              formPart(),
              SizedBox(height: 40),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget topPage() {
    return Column(

      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              'Register',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 150),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Login',
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget formPart() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          // focusNode: _accountFocus,
          // _fieldFocusChange(context, _accountFocus, _firstNameFocus),
          decoration: InputDecoration(
            icon: Icon(Icons.account_balance_sharp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.black26, width: 2.0),
            ),
            labelText: 'Account type',
          ),
          validator: (val) {
            // Если поле не заполнено то вызвай ноль
            return val == null ? 'Please choose an account' : null;
          },
          items: _accountType.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: (value) => setState(() {
            _selectedAccount = value!;
            newUser.account = value; //-----!
          }),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(
              width: 170,
              child: TextFormField(
                focusNode: _firstNameFocus,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _firstNameFocus, _lastNameFocus);
                },
                validator: _validateFirstName,
                onSaved: (value) => newUser.firstName = value!,
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  // hintText: 'What do people call you?',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _firstNameController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black26, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 170,
              child: TextFormField(
                focusNode: _lastNameFocus,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _lastNameFocus, _emailFocus);
                },
                validator: _validateLastName,
                onSaved: (value) => newUser.lastName = value!,
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  // hintText: 'What do people call you?',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _lastNameController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black26, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        TextFormField(
          focusNode: _emailFocus,
          onFieldSubmitted: (_) {
            _fieldFocusChange(context, _emailFocus, _phoneFocus);
          },
          onSaved: (value) => newUser.email = value!,
          validator: _validateEmail,
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            // hintText: 'What do people call you?',
            prefixIcon: Icon(Icons.mail),
            suffixIcon: IconButton(
              onPressed: () {
                _emailController.clear();
              },
              icon: Icon(Icons.clear),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.black26, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20),
        TextFormField(
          focusNode: _phoneFocus,
          onFieldSubmitted: (_) {
            _fieldFocusChange(context, _phoneFocus, _passFocus);
          },
          onSaved: (value) => newUser.phone = value!,
          validator: _validatePhone,
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Phone',
            helperText: 'Phone number format: +996(XXX)XXX-XXX',
            // hintText: 'What do people call you?',
            prefixIcon: Icon(Icons.phone),
            suffixIcon: IconButton(
              onPressed: () {
                _phoneController.clear();
              },
              icon: Icon(Icons.clear),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.black26, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
          keyboardType: TextInputType.phone,
          maxLength: 9,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(
              width: 170,
              child: TextFormField(
                focusNode: _passFocus,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _passFocus, _confirmPassFocus);
                },
                controller: _passController,
                obscureText: _hidePass,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    // если true, то видно, если не так, то не видно.
                    icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        // меняются
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black26, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                maxLength: 9,
                validator: _validatePassword,
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 170,
              child: TextFormField(
                focusNode: _confirmPassFocus,
                controller: _confirmPassController,
                obscureText: _hidePass,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _confirmPassController.clear();
                      _passController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black26, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                maxLength: 9,
                validator: _validatePassword,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        _submitForm();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserInfoPage(
            userInfo: newUser,
          )),
        );
      },
      child: Text(
        'Submit',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey,
      ),
    );
  }

  void _submitForm() {
    // просматривает текущее состояние поля
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Account type: $_selectedAccount');
      print('First name: ${_firstNameController.text}');
      print('Last name: ${_lastNameController.text}');
      print('Email: ${_emailController.text}');
      print('Phone: ${_phoneController.text}');
    } else {
      print('Something wrong! Review please');
    }
  }

  final _charactersExp = RegExp(r'^[A-Za-z]+$');

  String? _validateFirstName(value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    } else if (!_charactersExp.hasMatch(value)) {
      return 'Enter alphabetical characters';
    } else {
      return null;
    }
  }

  String? _validateLastName(value) {
    final _charactersExp = RegExp(r'^[A-Za-z]+$');
    if (value == null || value.isEmpty) {
      return 'Last name required';
    } else if (!_charactersExp.hasMatch(value)) {
      return 'Enter alphabetical characters';
    } else {
      return null;
    }
  }

  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Email address cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email address.';
    } else {
      return null;
    }
  }

  String? _validatePhone(value) {
    final _phoneExp = RegExp(r'^\d\d\d\d\d\d\d\d\d$');
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!_phoneExp.hasMatch(value)) {
      return 'Invalid phone number';
    } else {
      return null;
    }
  }

  String? _validatePassword(value) {
    if (_passController.text.length != 9) {
      return '9 characters required';
    } else if (_confirmPassController.text != _passController.text) {
      return 'Does not match';
    } else {
      return null;
    }
  }
}
