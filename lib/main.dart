// Fichier : lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// Ce fichier est généré lorsque vous exécutez 'flutterfire configure'
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/ajouter_redacteur_page.dart';
import 'pages/liste_redacteurs_page.dart';

void main() async {
  // 1. OBLIGATOIRE : Assure que Flutter est initialisé avant d'appeler des méthodes natives (comme Firebase)
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialisation de Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Message');
    ("Firebase initialisé avec succès !");
  } catch (e) {
    // Afficher une erreur si l'initialisation échoue
    debugPrint('Message');
    ("Erreur d'initialisation de Firebase : $e");
  }

  // 3. Lancement de l'application
  runApp(const MonApplication());
}

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App Firebase',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Vous pouvez utiliser un Widget qui vérifie l'état de Firebase avant d'afficher l'interface utilisateur
      home: const MyHomePage(title: 'Accueil Firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Votre logique de page ici...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const Center(
        child: Text(
          'Application Firebase Démarrée Correctement !',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// ÉTAPE 2: DÉFINITION DE L'APPLICATION ET DES ROUTES
// ----------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazine Infos - Gestion Rédacteurs',
      theme: ThemeData(
        // Utilisez une couleur pour correspondre au thème du magazine
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
        ),
      ),
      // Définition de la route initiale et des routes nommées
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(), // La page d'accueil avec le Drawer
        '/ajouter_redacteur': (context) =>
            AjouterRedacteurPage(), // Page pour le CRUD (Create)
        '/liste_redacteurs': (context) =>
            ListeRedacteursPage(), // Page pour le CRUD (Read, Update, Delete)
        // Note: La page de modification est généralement appelée directement (push)
        // et non via une route nommée, car elle nécessite un objet Redacteur.
      },
    );
  }
}
