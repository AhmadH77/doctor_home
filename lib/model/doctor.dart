class Doctor {
  final String id, name, username, email, phone, password;

  Doctor(
      this.id, this.name, this.email, this.phone, this.username, this.password);

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "email": this.email,
        "phone": this.phone,
        "username": this.username,
        "password": this.password,
      };
}
