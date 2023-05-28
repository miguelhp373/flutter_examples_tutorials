// ignore_for_file: use_key_in_widget_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:rest_call_api_http_methods/services/api_request.dart';

class UsersDetails extends StatefulWidget {
  @override
  State<UsersDetails> createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> {
  ////////////////////////////////////////////////////
  final _formKeySubmitAction = GlobalKey<FormState>();
  final Map<String, String> _isFormDataObject = {};

  void formSubmitAction(bool isActionSubmitValid, int userIdentity) async {
    if (isActionSubmitValid) {
      _formKeySubmitAction.currentState?.save();
      _isFormDataObject['id'] = userIdentity.toString();
      _isFormDataObject['avatar'] = '';

      final responseApi = await ApiRequest().putData(
        '/users/$userIdentity',
        userIdentity,
        _isFormDataObject,
      );
      final statusCode = responseApi.statusCode;
      print('Api Code Return: $statusCode');
    }
    return;
  }

  void deleteUserAction(int userIdentity, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação de Exclusão'),
          content: const Text('Deseja realmente excluir este usuário?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () async {
                Navigator.of(context).pop(); // Fechar o diálogo de confirmação

                final responseApi =
                    await ApiRequest().deleteData('/users/$userIdentity');
                final statusCode = responseApi.statusCode;
                print('Api Code Return: $statusCode');

                if (statusCode == 204) {
                  // A exclusão foi bem-sucedida
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuário excluído com sucesso'),
                    ),
                  );
                } else {
                  // A exclusão falhou
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Falha ao excluir o usuário')),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => deleteUserAction(userId, context),
          ),
        ],
      ),
      body: FutureBuilder<Response<dynamic>>(
        future: ApiRequest().fetchData('/users/$userId'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else {
            var user = snapshot.data!.data['data'];
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKeySubmitAction,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(user['avatar']),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const Text('Name'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFdfe6e9),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          initialValue: user['first_name'],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "The first name can't not empty";
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _isFormDataObject['first_name'] = value!,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const Text('Last Name'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFdfe6e9),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          initialValue: user['last_name'],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "The last name can't not empty";
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _isFormDataObject['last_name'] = value!,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const Text('Email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFdfe6e9),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          initialValue: user['email'],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "The email can't not empty";
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _isFormDataObject['email'] = value!,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => formSubmitAction(
                          _formKeySubmitAction.currentState!.validate(),
                          userId,
                        ),
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              'Save',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
