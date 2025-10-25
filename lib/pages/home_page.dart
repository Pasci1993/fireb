import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magazine Infos'),
        backgroundColor: Colors.blueGrey,
      ),
      // Le menu de navigation
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // En-tête du Drawer
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text(
                'Menu du Magazine',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // Option 1 : Ajouter un Rédacteur
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Ajouter un Rédacteur'),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
                // Navigue vers la page d'ajout
                Navigator.pushNamed(context, '/ajouter_redacteur');
              },
            ),
            // Option 2 : Informations des Rédacteurs
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Informations des Rédacteurs'),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
                // Navigue vers la page de liste
                Navigator.pushNamed(context, '/liste_redacteurs');
              },
            ),
            // ... autres options de navigation
          ],
        ),
      ),
      // Contenu de la page d'accueil (votre code existant)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // [Image of magazine cover]
            Text(
              'Bienvenue sur Magazine Infos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Votre source d'information en temps réel. Utilisez le menu pour gérer les rédacteurs.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
