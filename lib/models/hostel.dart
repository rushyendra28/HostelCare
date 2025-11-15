class Hostel {
  final String id;
  final String name;
  final String location;
  final double rating;
  final int reviews;
  final String? about;
  final List<String> amenities;
  final bool isJoined;

  Hostel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviews,
    this.about,
    this.amenities = const [],
    this.isJoined = false,
  });

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      about: json['about'],
      amenities: List<String>.from(json['amenities'] ?? []),
      isJoined: json['isJoined'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'rating': rating,
      'reviews': reviews,
      'about': about,
      'amenities': amenities,
      'isJoined': isJoined,
    };
  }
}