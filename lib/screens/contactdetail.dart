import 'package:flutter/material.dart';
import 'package:reposicaomobile/model/nameslist.dart';
import 'package:reposicaomobile/model/nomes.dart';

class ContactDetailPage extends StatefulWidget {
  final ContactInfo contact;

  ContactDetailPage({Key? key, required this.contact}) : super(key: key);

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _noteController;
  final ContactsList contactsList = ContactsList();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.nome);
    _surnameController = TextEditingController(text: widget.contact.sobrenome);
    _phoneController = TextEditingController(text: widget.contact.telefone);
    _emailController = TextEditingController(text: widget.contact.email);
    _noteController = TextEditingController(text: widget.contact.observacao);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveContact() async {
    try {
      ContactInfo updatedContact = ContactInfo(
        id: widget.contact.id, // Ensure ID is preserved
        nome: _nameController.text,
        sobrenome: _surnameController.text,
        telefone: _phoneController.text,
        email: _emailController.text,
        observacao: _noteController.text,
        avatarUrl: widget.contact.avatarUrl, // Preserve avatar URL
        status: widget.contact.status, // Preserve status
      );

      await contactsList
          .updateContact(updatedContact); // ✅ Using the new method

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${updatedContact.nome} atualizado!')),
      );

      Navigator.pop(context, updatedContact);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar contato')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Contato"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveContact,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Nome", _nameController),
            _buildTextField("Sobrenome", _surnameController),
            _buildTextField("Telefone", _phoneController),
            _buildTextField("Email", _emailController),
            _buildTextField("Observação", _noteController),
            SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.star_border),
          onPressed: () async {
            try {
              await contactsList.updateToFavorite(widget.contact);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.contact.nome} favoritado!')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao favoritar contato')),
              );
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.block),
          onPressed: () async {
            try {
              await contactsList.updateToBlocked(widget.contact);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.contact.nome} bloqueado!')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao bloquear contato')),
              );
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            try {
              await contactsList.removeContact(widget.contact);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.contact.nome} deletado!')),
              );
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao deletar contato')),
              );
            }
          },
        ),
      ],
    );
  }
}
