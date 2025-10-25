// Fichier : lib/pages/modifier_redacteur_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/redacteur.dart';

class ModifierRedacteurPage extends StatefulWidget {
  final Redacteur redacteur;

  const ModifierRedacteurPage({super.key, required this.redacteur});

  @override
  _ModifierRedacteurPageState createState() => _ModifierRedacteurPageState();
}

class _ModifierRedacteurPageState extends State<ModifierRedacteurPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _specialiteController;

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs avec les données actuelles
    _nomController = TextEditingController(text: widget.redacteur.nom);
    _specialiteController = TextEditingController(
      text: widget.redacteur.specialite,
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  // Fonction pour mettre à jour le rédacteur dans Firestore
  void _modifierRedacteur() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('rédacteurs')
            .doc(widget.redacteur.id) // Ciblage par l'ID
            .update({
              'nom': _nomController.text,
              'specialite': _specialiteController.text,
              'date_modification': FieldValue.serverTimestamp(),
            });

        // Confirmation et retour
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rédacteur modifié avec succès !')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur de modification: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Rédacteur : ${widget.redacteur.nom}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomController, // Contrôleur pré-rempli
                decoration: InputDecoration(labelText: 'Nom du Rédacteur'),
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer un nom' : null,
              ),
              TextFormField(
                controller: _specialiteController, // Contrôleur pré-rempli
                decoration: InputDecoration(labelText: 'Spécialité'),
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer une spécialité' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _modifierRedacteur,
                child: Text('Enregistrer les Modifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
