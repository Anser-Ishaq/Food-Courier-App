class User {
  String? uid;
  String? name;
  String? email;
  String? address;
  double? longitude;
  double? latitude;

  User({
    this.uid,
    this.name,
    this.email,
    this.address,
    this.longitude,
    this.latitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
