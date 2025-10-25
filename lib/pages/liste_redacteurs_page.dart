// Fichier : lib/pages/liste_redacteurs_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/redacteur.dart'; // Assurez-vous d'importer votre modèle
import 'modifier_redacteur_page.dart'; // Page à créer

class ListeRedacteursPage extends StatelessWidget {
  const ListeRedacteursPage({super.key});

  // Fonction de suppression (implémentée ici pour la simplicité)
  void _supprimerRedacteur(BuildContext context, String redacteurId) async {
    await FirebaseFirestore.instance
        .collection('rédacteurs')
        .doc(redacteurId)
        .delete();

    // Boîte de dialogue de confirmation (Post-suppression)
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Suppression Réussie"),
        content: Text("Le rédacteur a été supprimé de la base de données."),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  // Boîte de dialogue de confirmation de suppression (Pré-suppression)
  void _confirmerSuppression(BuildContext context, Redacteur redacteur) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Confirmer la Suppression"),
        content: Text("Êtes-vous sûr de vouloir supprimer ${redacteur.nom} ?"),
        actions: <Widget>[
          TextButton(
            child: Text("Annuler"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text("Supprimer", style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(ctx).pop(); // Ferme la boîte de dialogue
              _supprimerRedacteur(
                context,
                redacteur.id,
              ); // Exécute la suppression
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Rédacteurs')),
      body: StreamBuilder<QuerySnapshot>(
        // Écoute les changements dans la collection 'rédacteurs'
        stream: FirebaseFirestore.instance.collection('rédacteurs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucun rédacteur trouvé.'));
          }

          final redacteurs = snapshot.data!.docs.map((doc) {
            return Redacteur.fromFirestore(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();

          return ListView.builder(
            itemCount: redacteurs.length,
            itemBuilder: (context, index) {
              final redacteur = redacteurs[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  title: Text(
                    redacteur.nom,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(redacteur.specialite),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icône Modifier
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Navigue vers la page de modification en passant l'objet Redacteur
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ModifierRedacteurPage(redacteur: redacteur),
                            ),
                          );
                        },
                      ),
                      // Icône Supprimer
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            _confirmerSuppression(context, redacteur),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
