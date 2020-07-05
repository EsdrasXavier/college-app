import 'dart:ffi';

class Billing {
  final int id;
  final double value;
  final double actualCost;
  final double scholarshipValue;
  final String expirationDate;

  Billing(
      {this.id,
      this.value,
      this.scholarshipValue,
      this.actualCost,
      this.expirationDate});

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
        id: json['id'],
        value: json['value'].toDouble(),
        scholarshipValue: json['scholarship_value'].toDouble(),
        actualCost: json['actual_cost'].toDouble(),
        expirationDate: json['expiration_date']);
  }
}
