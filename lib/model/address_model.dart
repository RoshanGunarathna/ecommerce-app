// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  final String id;
  final String fullName;
  final String address;
  final String mobileNumber;
  final String province;
  final String cityTown;
  final String zipCode;
  final DateTime? dateTime;

  AddressModel({
    required this.id,
    required this.fullName,
    required this.address,
    required this.mobileNumber,
    required this.province,
    required this.cityTown,
    required this.zipCode,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'address': address,
      'mobileNumber': mobileNumber,
      'province': province,
      'zipCode': zipCode,
      'cityTown': cityTown,
      'dateTime': dateTime.toString(),
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      address: map['address'] as String,
      mobileNumber: map['mobileNumber'] as String,
      province: map['province'] as String,
      cityTown: map['cityTown'] as String,
      zipCode: map['zipCode'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
    );
  }

//map list to product List
  static List<AddressModel> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((e) => AddressModel.fromMap(e)).toList();
  }

  AddressModel copyWith({
    String? fullName,
    String? address,
    String? mobileNumber,
    String? province,
    String? cityTown,
    String? zipCode,
    DateTime? dateTime,
    String? id,
  }) {
    return AddressModel(
      fullName: fullName ?? this.fullName,
      zipCode: zipCode ?? this.zipCode,
      address: address ?? this.address,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      province: province ?? this.province,
      cityTown: cityTown ?? this.cityTown,
      dateTime: dateTime ?? this.dateTime,
      id: id ?? this.id,
    );
  }
}
