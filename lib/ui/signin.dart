import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
class SignIn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SignInPage();
  }
}

class SignInPage extends StatefulWidget{
  SignInPage({Key key}) : super(key: key);
  @override
  SignInPageSate createState() => new SignInPageSate();
}

class SignInPageSate extends State<SignInPage>{

  // Create controller for editext
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController retypePasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Sign in"),
      ),
      body: new Column(
        children: <Widget>[
          _inputTextField("User name", usernameController, false),
          _inputTextField("Password", passwordController, true),
          _inputTextField("Retype password", retypePasswordController, true),
          _buttonForm(),
        ],
      ),
    );
  }

  void _finishSignIn(){
    // Get user name and password
    final String username = usernameController.text;
    final String password = passwordController.text;

    final String retype = retypePasswordController.text;

    if(!_checkIsSamePassword(password, retype)){
      print("Please check password again");
      _showDialog("Error","Please check password again");
    }else{
      _handleStorageNewUser(username, password);
    }

  }

  void _handleStorageNewUser(String username, String password) async {

    Map<String, dynamic> content = new Map();

    var content1 = {'username': username};
    var content2 = {'password': password};

    content.addAll(content1);
    content.addAll(content2);

    print(content);

    // Notify register success
    _showDialog("Success", "Register was Success");
    print(_localPath);

  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  bool _checkIsSamePassword(String password, String retype){
    // Compare password and retype password
    if(password.compareTo(retype) == 0){
      return true;
    }
    return false;
  }

  void _cancel(){
    print("Cancel");
    Navigator.of(context).pop();
  }

  void _showDialog(String title, String content){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
            },
                child: new Text("Close"))
          ],
        );
      }
    );
  }

  Widget _buttonForm(){
    return new Row(
      children: <Widget>[
        _button("OK", _finishSignIn),
        _button("Cancel",_cancel)
      ],
    );
  }

  TextField _inputTextField(String placholder, TextEditingController controller, bool obscureText){
    return TextField(
      textAlign: TextAlign.left,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: placholder,
      ),
    );
  }

  RaisedButton _button (String btnTitle, Function function){
    return RaisedButton(
      onPressed: (){
        function();
      },
      child: new Text(btnTitle),
    );
  }
}