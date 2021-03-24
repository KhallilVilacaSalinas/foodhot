import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodhot/Components/HeaderLogin.dart';
import 'package:foodhot/model/usuario.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _senhacontroller = TextEditingController();
  TextEditingController _nomecontroller = TextEditingController();
  String _mensagemErro = "";
  

  _validarCapos() async {
    String senha =  _senhacontroller.text; 
    String nome = _nomecontroller.text; 
    String email = _emailcontroller.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains('@')) {
        if (senha.isNotEmpty) {
          if (senha.length >= 6) {
            setState(() {
              _mensagemErro = "";
            });

            Usuario usuario = Usuario();
            usuario.nome = nome;
            usuario.email = email;
            usuario.senha = senha;

            _cadastrarUsuario(usuario);
          } else {
            setState(() {
              _mensagemErro = "Preencha com mais de 5 digitos.";
            });
          }
        } else {
          setState(() {
            _mensagemErro = "Preencha a senha.";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha o email.";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o nome.";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) async {
    FirebaseAuth auth = FirebaseAuth.instance;


    auth.createUserWithEmailAndPassword(
          email: usuario.email, 
          password: usuario.senha).then((firebsaeUser) {

      FirebaseFirestore db = FirebaseFirestore.instance;

      db.collection('usuarios').
      doc(firebsaeUser.user.uid).
      set(usuario.toMap()); 

      setState(() {
        _mensagemErro = 'Cadastrado com sucesso';
      });

      FocusScope.of(context).unfocus();
    }).catchError((onError) {
      print('Erro: ' + onError.toString());
    });
    //FirebaseAuth auth = FirebaseAuth.instance;

    User userAtual = auth.currentUser;

    if (userAtual != null) {
      print("User Logado!");
    } else {
      print("User Deslogado!");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color(0xfffe0000),
          Color(0xfffe0000),
          Color(0xfffe0000),
        ])),
        child: Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              HeaderLogin(),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 10,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(75),
                            topRight: Radius.circular(75))),
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(225, 95, 27, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                     Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(color: Colors.grey[200]))),
                                      child: TextField(
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: "Nome",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        onSubmitted: (String texto) {
                                          setState(() {
                                            _nomecontroller.text = texto;
                                          });
                                        },
                                        controller: _nomecontroller,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide( color: Colors.grey[200]))),
                                      child: TextField(
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        onSubmitted: (String texto) {
                                          setState(() {
                                            _emailcontroller.text = texto;
                                          });
                                        },
                                        controller: _emailcontroller,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        onSubmitted: (String texto) {
                                          setState(() {
                                            _senhacontroller.text = texto;
                                          });
                                        },
                                        controller: _senhacontroller,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.045,
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xfffe0000),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _validarCapos();
                                },
                              ),
                              Text(_mensagemErro),
                              //Spacer(flex: 1,),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "I have an account",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      onTap: () {
                                        _emailcontroller.text = "";
                                        _senhacontroller.text = "";
                                        Navigator.of(context).pop('/');
                                        FocusScope.of(context).unfocus();
                                        //Coloque o focus em baixo do Navigator para
                                        //que quando voltar para o login, não abrir o teclado.
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
