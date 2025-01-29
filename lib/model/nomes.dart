import 'package:flutter/cupertino.dart';

class ContactInfo with ChangeNotifier {
  final String id;
  final String nome;
  final String sobrenome;
  final String telefone;
  final String email;
  String status;
  final String avatarUrl;
  final String observacao;

  ContactInfo({
    required this.id,
    required this.nome,
    required this.sobrenome,
    required this.telefone,
    required this.email,
    required this.status,
    required this.avatarUrl,
    required this.observacao,
  });

  ContactInfo.fromProduct(ContactInfo _contactinfo)
      : id = _contactinfo.id,
        nome = _contactinfo.nome,
        sobrenome = _contactinfo.sobrenome,
        telefone = _contactinfo.telefone,
        email = _contactinfo.email,
        status = _contactinfo.status,
        avatarUrl = _contactinfo.avatarUrl,
        observacao = _contactinfo.observacao;

  factory ContactInfo.fromJson(String id, Map<String, dynamic> json) {
    return ContactInfo(
      id: id,
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      telefone: json['telefone'],
      email: json['email'],
      status: json['status'],
      avatarUrl: json['avatarUrl'],
      observacao: json['observacao'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'telefone': telefone,
      'email': email,
      'status': status,
      'avatarUrl': avatarUrl,
      'observacao': observacao,
    };
    return data;
  }
}
