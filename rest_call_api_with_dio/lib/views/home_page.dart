import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rest_call_api_http_methods/services/api_request.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    'ShopX',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.view_list_rounded),
                  onPressed: null,
                ),
                IconButton(
                  icon: Icon(Icons.grid_view),
                  onPressed: null,
                ),
              ],
            ),
          ),
          FutureBuilder<Response>(
            future: ApiRequest().fetchData('/users'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar dados'));
              } else {
                var data = snapshot.data!.data['data'];
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var user = data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/user-details',
                          arguments: user['id'],
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user['avatar']),
                        ),
                        title:
                            Text('${user['first_name']} ${user['last_name']}'),
                        subtitle: Text(user['email']),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
