import 'package:dashstore/blocs/login_bloc.dart';
import 'package:dashstore/screens/homescreen.dart';
import 'package:dashstore/widgets/inputfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
          break;
        case LoginState.FAIL:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Acesso Negado"),
              content: Text("Você não tem privilégios suficientes para acesso"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Fechar"),
                ),
              ],
            ),
          );
          break;
        default:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          print(snapshot.data);
          switch (snapshot.data) {
            case LoginState.LOADING:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              );
            case LoginState.FAIL:
            case LoginState.SUCCESS:
            case LoginState.IDLE:
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.store,
                            color: Theme.of(context).primaryColor,
                            size: 160,
                          ),
                          InputField(
                            onChanged: _loginBloc.changeEmail,
                            stream: _loginBloc.outEmail,
                            icon: Icons.person_outline,
                            hint: "Usuário",
                            obscure: false,
                          ),
                          InputField(
                            onChanged: _loginBloc.changePassword,
                            stream: _loginBloc.outPassword,
                            icon: Icons.lock_outline,
                            hint: "Senha",
                            obscure: true,
                          ),
                          SizedBox(height: 25),
                          StreamBuilder<bool>(
                              stream: _loginBloc.outSubmitValid,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 50,
                                  child: RaisedButton(
                                    child: Text(
                                      "Entrar",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    disabledColor: Theme.of(context)
                                        .primaryColor
                                        .withAlpha(140),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: snapshot.hasData
                                        ? _loginBloc.submit
                                        : null,
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
