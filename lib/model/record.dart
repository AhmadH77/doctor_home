import 'package:rapid_medical_info_system/model/patient.dart';

class Record {
  final int id, patient_id;
  final String disease, drugs,endemic,diagnosis;
  final Patient patient;

  Record(this.id, this.patient_id, this.disease, this.drugs, this.endemic, this.diagnosis, this.patient);

  static Record fromJson(json) =>
      Record(
          json['id'],
          json['patient_id'],
          json['disease'],
          json['drugs'] ?? '',
          json['have_endemic'] ?? '',
          json['diagnosis'] ?? '',
        Patient.fromJson1(json)
      );
}
