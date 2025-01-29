import 'package:flutter/material.dart';
import 'package:reposicaomobile/model/nomes.dart';
import 'package:reposicaomobile/screens/addcontato.dart';
import 'package:reposicaomobile/screens/allcontacts.dart';
import 'package:reposicaomobile/screens/blockedpage.dart';
import 'package:reposicaomobile/screens/contactdetail.dart';
import 'package:reposicaomobile/screens/favoritespage.dart';
import 'package:reposicaomobile/screens/mainscreen.dart';
import 'package:reposicaomobile/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.MAINSCREEN,
      routes: {
        AppRoutes.MAINSCREEN: (ctx) => const Mainscreen(),
        AppRoutes.LISTANORMAL: (ctx) => const Mainscreen(),
        AppRoutes.LISTAFAVORITOS: (ctx) => FavoritesPage(),
        AppRoutes.LISTABLOQUEADOS: (ctx) => BlockedPage(),
        AppRoutes.ALUNOINFO: (ctx) => const Mainscreen(),
        AppRoutes.ADDCONTATO: (ctx) => ContactRegistrationScreen(),
        AppRoutes.GERENCIAMENTO: (ctx) => AllContactsScreen(),
      },
    );
  }
}
