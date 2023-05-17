// ignore_for_file: use_key_in_widget_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rest_call_api_http_methods/services/api_request.dart';

class UsersDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user['avatar']),
                  ),
                  const SizedBox(height: 16),
                  Text('${user['first_name']} ${user['last_name']}'),
                  Text(user['email']),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
