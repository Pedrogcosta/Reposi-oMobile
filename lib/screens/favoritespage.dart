import 'package:flutter/material.dart';
import 'package:reposicaomobile/model/nameslist.dart';
import 'package:reposicaomobile/model/nomes.dart';

class FavoritesPage extends StatelessWidget {
  final ContactsList contactsList = ContactsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Favoritos")),
      body: FutureBuilder<List<ContactInfo>>(
        future: contactsList.fetchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Carregando...
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum contato encontrado"));
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }

          // Dados carregados com sucesso
          List<ContactInfo> contacts = snapshot.data!;

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(contacts[index].nome),
                subtitle: Text(contacts[index].sobrenome),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          await contactsList.updateToNormal(contacts[index]);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Contato ${contacts[index].nome} desfavoritado!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Erro ao desfavoritar contato')),
                          );
                        }
                      },
                      icon: Icon(Icons.star),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await contactsList.updateToBlocked(contacts[index]);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Contato ${contacts[index].nome} bloqueado!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro ao bloquear contato')),
                          );
                        }
                      },
                      icon: Icon(Icons.block),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await contactsList.removeContact(contacts[index]);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Contato ${contacts[index].nome} deletado!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro ao deletar contato')),
                          );
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
