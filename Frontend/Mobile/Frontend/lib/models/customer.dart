class Customer {
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String? city;
  final String? district;
  final String? postalCode;
  final String? password;

  Customer({
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.city,
    this.district,
    this.postalCode,
    this.password,
  });

  Customer copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? district,
    String? postalCode,
    String? password,
  }) {
    return Customer(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      district: district ?? this.district,
      postalCode: postalCode ?? this.postalCode,
      password: password ?? this.password,
    );
  }
}
