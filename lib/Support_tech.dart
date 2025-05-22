class SupportTechnique {
  final String id;
  final String nom;
  final String email;
  final String role;

  SupportTechnique(
      {required this.id,
      required this.nom,
      required this.email,
      required this.role});

  factory SupportTechnique.fromJson(Map<String, dynamic> json) {
    // Safely handle the _id field, which we don't need
    return SupportTechnique(
      id: json['_id'] ?? '', // Handle null or missing fields
      nom: json['nom'] ?? '', // Handle null or missing fields
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
