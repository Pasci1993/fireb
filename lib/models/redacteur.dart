class Redacteur {
  final String id; // L'ID du document Firestore
  final String nom;
  final String specialite;

  Redacteur({required this.id, required this.nom, required this.specialite});

  // Factory pour créer un objet Redacteur à partir d'un document Firestore
  factory Redacteur.fromFirestore(Map<String, dynamic> data, String id) {
    return Redacteur(
      id: id,
      nom: data['nom'] as String? ?? 'Nom Inconnu',
      specialite: data['specialite'] as String? ?? 'Spécialité Inconnue',
    );
  }

  // Méthode pour convertir l'objet Redacteur en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'nom': nom,
      'specialite': specialite,
      // Vous pourriez ajouter ici un champ 'date_ajout' : FieldValue.serverTimestamp()
    };
  }
}
