// address_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String ward;
  final String district;
  final String province;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.ward,
    required this.district,
    required this.province,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      id: '', name: '', phoneNumber: '', street: '', ward: '', district: '', province: ''
  );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'Ward': ward,
      'District': district,
      'Province': province,
      'DateTime': dateTime,
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String? ?? '',
      name: data['Name'] as String? ?? '',
      phoneNumber: data['PhoneNumber'] as String? ?? '',
      street: data['Street'] as String? ?? '',
      ward: data['Ward'] as String? ?? '',
      district: data['District'] as String? ?? '',
      province: data['Province'] as String? ?? '',
      selectedAddress: data['SelectedAddress'] as bool? ?? false,
      dateTime: data['DateTime'] is Timestamp
          ? (data['DateTime'] as Timestamp).toDate()
          : (data['DateTime'] is String && data['DateTime'].isNotEmpty
          ? DateTime.tryParse(data['DateTime'])
          : null),
    );
  }
}