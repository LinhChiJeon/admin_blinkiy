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
  // final String country;
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
    // required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(id: '', name: '', phoneNumber: '', street: '', ward: '', district: '', province: '');

  Map<String, dynamic> toJson(){
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'Ward': ward,
      'District': district,
      'Province': province,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      street: data['Street'] as String,
      ward: data['Ward'] as String,
      district: data['District'] as String,
      province: data['Province'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),

    );

  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      ward: data['Ward'] ?? '',
      district: data['District'] ?? '',
      province: data['Province'] ?? '',
      selectedAddress: data['SelectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  @override
  String toString(){
    return '$street, $ward, $district, $province';
  }



}