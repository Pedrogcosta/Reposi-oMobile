import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showBlockedContacts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Mostrar contatos bloqueados'),
            subtitle: Text(_showBlockedContacts
                ? 'Contatos bloqueados serão visíveis'
                : 'Contatos bloqueados serão ocultados'),
            value: _showBlockedContacts,
            onChanged: (bool value) {
              setState(() {
                _showBlockedContacts = value;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_showBlockedContacts
                      ? 'Contatos bloqueados ativados'
                      : 'Contatos bloqueados desativados'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
