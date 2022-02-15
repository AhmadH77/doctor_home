class Patient {
  final String id,age, name, email, phone, qr, password, nationalId;

  Patient(this.id, this.name, this.email, this.phone, this.qr, this.password,
      this.nationalId, this.age);

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "email": this.email,
        "phone": this.phone,
        "qr": this.qr,
        "password": this.password,
        "age": this.age,
      };

  static Patient fromJson(json) =>
      Patient(
          json['id'].toString(),
          json['name'],
          json['email'],
          json['phone'],
          json['qr'] ?? '',
          json['password'],
          json['national_id'] ,
          json['age'].toString() ,
      );

  static Patient fromJson1(json) =>
      Patient(
          json['patient_id'].toString(),
          json['name'],
          json['email'],
          json['phone'],
          json['qr'] ?? '',
          json['password'],
          json['national_id'],
          json['age'].toString(),
      );
}
