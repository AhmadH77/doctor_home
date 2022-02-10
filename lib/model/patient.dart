class Patient {
  final String id, name, email, phone, qr, password,nationalId;

  Patient(this.id, this.name, this.email, this.phone, this.qr, this.password, this.nationalId);

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "email": this.email,
        "phone": this.phone,
        "qr": this.qr,
        "password": this.password,
      };
}
