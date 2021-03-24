import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodhot/model/categoria.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Categoria> listConversas = [
    Categoria(
      'Ana Clara',
      'https://firebasestorage.googleapis.com/v0/b/whatsapp-7fa16.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=ce2113dc-45f1-40c7-b799-005a8731349d',
    ),
    Categoria(
      'Pedro Silva',
      'https://firebasestorage.googleapis.com/v0/b/whatsapp-7fa16.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=625b327d-d06f-43a4-8fee-940b2bea2f42',
    ),
    Categoria(
      'Marcela almeida',
      'https://firebasestorage.googleapis.com/v0/b/whatsapp-7fa16.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=56f1c8ba-a143-4452-ae4c-831d99d893fc',
    ),
    Categoria(
      'José Renato',
      'https://firebasestorage.googleapis.com/v0/b/whatsapp-7fa16.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=cc525b64-e6ed-44d2-88df-c621a0f8516e',
    ),
    Categoria(
    'Jamilton',
    'https://firebasestorage.googleapis.com/v0/b/whatsapp-7fa16.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=fb7f00ae-19eb-4287-a838-c94b0168e7c4'),
  ];

  List<String> _locations = [
    'Rua Hansler de freitas, 141',
    'B',
    'C',
    'D'
  ]; // Option 2
  String _selectedLocation; // Option 2

  _deslogarusuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.popAndPushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.menu,
                      size: 32,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                        flex: 4,
                        child: SizedBox(
                          width: 100,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                                hintText: 'pesquise um produto',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60.0)),
                                ),
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 24,
                                )),
                          ),
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                        child: Icon(
                          Icons.account_circle,
                          size: 27,
                        ),
                        onTap: () => _deslogarusuario()),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 6.0,
                          bottom: 16,
                        ),
                        child: DropdownButton(
                          hint: Text(
                              'Escolha um endereço'), // Not necessary for Option 1
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLocation = newValue;
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(
                                location,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              value: location,
                            );
                          }).toList(),
                        ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Categorias',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listConversas.length,
                    itemBuilder: (context, index) {
                      Categoria conversa = listConversas[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 0, left: 0, right: 9, top: 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(conversa.caminhoFoto),
                                  fit: BoxFit.cover)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                conversa.nome,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      'Mais pedidos',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                ),
                //list
              ],
            ),
          ),
        ),
      ),
    );
  }
}
