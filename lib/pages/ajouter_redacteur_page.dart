// Fichier : lib/pages/ajouter_redacteur_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AjouterRedacteurPage extends StatefulWidget {
  const AjouterRedacteurPage({super.key});

  @override
  _AjouterRedacteurPageState createState() => _AjouterRedacteurPageState();
}

class _AjouterRedacteurPageState extends State<AjouterRedacteurPage> {
  final _formKey = GlobalKey<FormState>();
  String _nom = '';
  String _specialite = '';

  // Fonction pour ajouter le rédacteur à Firestore
  void _ajouterRedacteur() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseFirestore.instance.collection('rédacteurs').add({
          'nom': _nom,
          'specialite': _specialite,
          'date_ajout': FieldValue.serverTimestamp(),
        });

        // Confirmation et retour à la page précédente
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rédacteur ajouté avec succès !')),
        );
        Navigator.pop(context);
      } catch (e) {
        // Gestion des erreurs
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter un Rédacteur')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom du Rédacteur'),
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer un nom' : null,
                onSaved: (value) => _nom = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Spécialité'),
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer une spécialité' : null,
                onSaved: (value) => _specialite = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _ajouterRedacteur,
                child: Text('Ajouter le Rédacteur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
