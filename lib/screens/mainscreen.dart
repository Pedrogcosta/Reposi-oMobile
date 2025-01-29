import 'package:flutter/material.dart';
import 'package:reposicaomobile/screens/addcontato.dart';
import 'package:reposicaomobile/screens/allcontacts.dart';
import 'package:reposicaomobile/screens/configs.dart';
import 'package:reposicaomobile/screens/favoritespage.dart';
import 'package:reposicaomobile/screens/homepage.dart';
import 'blockedpage.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.contacts_outlined)),
              Tab(icon: Icon(Icons.star_border)),
              Tab(icon: Icon(Icons.block)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            FavoritesPage(),
            BlockedPage(),
          ],
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mainscreen()),
                  );
                },
              ),
              ListTile(
                title: const Text('Gerenciamento'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllContactsScreen()),
                  );
                },
              ),
              ListTile(
                title: const Text('Configurações'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
