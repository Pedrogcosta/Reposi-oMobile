import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:reposicaomobile/model/nomes.dart';
import 'package:http/http.dart' as http;

class ContactsList with ChangeNotifier {
  final _baseUrl = 'https://mobile-87d86-default-rtdb.firebaseio.com/';

  List<ContactInfo> _names = [];
  bool _showFavoriteOnly = false;
  bool _showBlockedOnly = false;

  List<ContactInfo> get names {
    return _names.where((nome) => nome.status == 'normal').toList();
  }

  List<ContactInfo> get favoriteNumbers {
    return _names.where((nome) => nome.status == 'favorito').toList();
  }

  List<ContactInfo> get blockedNumbers {
    return _names.where((nome) => nome.status == 'bloqueado').toList();
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showBlockedOnly = false;
    notifyListeners();
  }

  Future<List<ContactInfo>> fetchAll() async {
    List<ContactInfo> contacts = [];

    try {
      final response = await http.get(Uri.parse('$_baseUrl/contacts.json'));

      if (response.statusCode == 200) {
        Map<String, dynamic> _contactsJson = jsonDecode(response.body);

        _contactsJson.forEach((id, contact) {
          contacts.add(ContactInfo.fromJson(id, contact));
        });
        _names = contacts;
        return contacts;
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<ContactInfo>> fetchNames() async {
    List<ContactInfo> contacts = [];

    try {
      final response = await http.get(Uri.parse('$_baseUrl/contacts.json'));

      if (response.statusCode == 200) {
        Map<String, dynamic> _contactsJson = jsonDecode(response.body);

        _contactsJson.forEach((id, contact) {
          if (contact['status'] == 'normal') {
            contacts.add(ContactInfo.fromJson(id, contact));
          }
        });
        _names = contacts;
        return contacts;
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<ContactInfo>> fetchFavorites() async {
    List<ContactInfo> favorites = [];

    try {
      final response = await http.get(Uri.parse('$_baseUrl/contacts.json'));

      if (response.statusCode == 200) {
        Map<String, dynamic> _contactsJson = jsonDecode(response.body);

        _contactsJson.forEach((id, contact) {
          if (contact['status'] == 'favorito') {
            favorites.add(ContactInfo.fromJson(id, contact));
          }
        });
        _names = favorites;
        return favorites;
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<ContactInfo>> fetchBlocked() async {
    List<ContactInfo> favorites = [];

    try {
      final response = await http.get(Uri.parse('$_baseUrl/contacts.json'));

      if (response.statusCode == 200) {
        Map<String, dynamic> _contactsJson = jsonDecode(response.body);

        _contactsJson.forEach((id, contact) {
          if (contact['status'] == 'bloqueado') {
            favorites.add(ContactInfo.fromJson(id, contact));
          }
        });
        _names = favorites;
        return favorites;
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> addContact(ContactInfo contact) async {
    try {
      var response = await http.post(Uri.parse('$_baseUrl/contacts.json'),
          body: jsonEncode(contact.toJson()));

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];
        _names.add(ContactInfo(
          id: id,
          nome: contact.nome,
          sobrenome: contact.sobrenome,
          telefone: contact.telefone,
          email: contact.email,
          status: contact.status,
          avatarUrl: contact.avatarUrl,
          observacao: contact.observacao,
        ));
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveContact(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final contact = ContactInfo(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      nome: data['name'] as String,
      sobrenome: data['description'] as String,
      telefone: data['price'] as String,
      email: data['imageUrl'] as String,
      status: 'normal',
      avatarUrl: data['description'] as String,
      observacao: data['price'] as String,
    );

    if (hasId) {
      return Future.value();
    } else {
      return addContact(contact);
    }
  }

  Future<void> removeContact(ContactInfo contact) async {
    try {
      final response =
          await http.delete(Uri.parse('$_baseUrl/contacts/${contact.id}.json'));

      if (response.statusCode == 200) {
        removeContactsFromList(contact);
      } else {
        throw Exception("Aconteceu algum erro durante a requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateToFavorite(ContactInfo contact) async {
    try {
      final updatedData = {
        'status': 'favorito',
        'nome': contact.nome,
        'sobrenome': contact.sobrenome,
        'telefone': contact.telefone,
        'email': contact.email,
        'avatarUrl': contact.avatarUrl,
        'observacao': contact.observacao,
      };
      final response = await http.patch(
        Uri.parse('$_baseUrl/contacts/${contact.id}.json'),
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        contact.status = 'favorito';
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro durante a requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateToBlocked(ContactInfo contact) async {
    try {
      final updatedData = {
        'status': 'bloqueado',
        'nome': contact.nome,
        'sobrenome': contact.sobrenome,
        'telefone': contact.telefone,
        'email': contact.email,
        'avatarUrl': contact.avatarUrl,
        'observacao': contact.observacao,
      };
      final response = await http.patch(
        Uri.parse('$_baseUrl/contacts/${contact.id}.json'),
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        contact.status = 'favorito';
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro durante a requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateToNormal(ContactInfo contact) async {
    try {
      final updatedData = {
        'status': 'normal',
        'nome': contact.nome,
        'sobrenome': contact.sobrenome,
        'telefone': contact.telefone,
        'email': contact.email,
        'avatarUrl': contact.avatarUrl,
        'observacao': contact.observacao,
      };
      final response = await http.patch(
        Uri.parse('$_baseUrl/contacts/${contact.id}.json'),
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        contact.status = 'favorito';
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro durante a requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  void removeContactsFromList(ContactInfo contact) {
    int index = _names.indexWhere((c) => c.id == contact.id);

    if (index >= 0) {
      _names.removeWhere((c) => c.id == contact.id);
      notifyListeners();
    }
  }

  Future<void> updateContact(ContactInfo contact) async {
    try {
      final updatedData = {
        'nome': contact.nome,
        'sobrenome': contact.sobrenome,
        'telefone': contact.telefone,
        'email': contact.email,
        'avatarUrl': contact.avatarUrl,
        'observacao': contact.observacao,
        // Status is NOT updated here
      };

      final response = await http.patch(
        Uri.parse('$_baseUrl/contacts/${contact.id}.json'),
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro durante a requisição");
      }
    } catch (e) {
      throw e;
    }
  }
}
