import 'package:flutter/material.dart';
import 'package:reposicaomobile/model/nameslist.dart';
import 'package:reposicaomobile/model/nomes.dart';
import 'package:reposicaomobile/screens/addcontato.dart';
import 'package:reposicaomobile/screens/contactdetail.dart';
import 'package:reposicaomobile/utils/app_routes.dart';

class AllContactsScreen extends StatelessWidget {
  final ContactsList contactsList = ContactsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<ContactInfo>>(
        future: contactsList.fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum contato encontrado"));
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }

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
                          await contactsList.updateToFavorite(contacts[index]);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Contato ${contacts[index].nome} favoritado!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Erro ao favoritar contato')),
                          );
                        }
                      },
                      icon: Icon(Icons.star_border),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactRegistrationScreen()),
          );
        },
      ),
    );
  }
}
