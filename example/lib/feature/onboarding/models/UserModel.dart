// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString?);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String? userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.role,
        this.phoneNumber,
        this.verified,
        this.createdAt,
        this.profilePhoto,
        this.addresses
    });

    String? id;
    String? firstName;
    String? lastName;
    String? email;
    String? role;
    String? phoneNumber;
    bool? verified;
    String? createdAt;
    String? profilePhoto;
    List<Address>? addresses;

    factory UserModel.fromJson(Map<String?, dynamic> json) => UserModel(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        role: json["role"],
        phoneNumber: json["phoneNumber"],
        verified: json["verified"],
        createdAt: json["createdAt"],
        profilePhoto: json["profilePhoto"],
        addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "role": role,
        "phoneNumber": phoneNumber,
        "verified": verified,
        "createdAt": createdAt,
        "profilePhoto": profilePhoto,
        "addresses": List<dynamic>.from(addresses!.map((x) => x)),
    };
}




class Address {
    Address({
        this.id,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.address,
        this.state,
        this.city,
        this.gender,
        this.dob,
        this.country,
        this.postalCode,
        this.isDefault,
    });

    String? id;
    String? firstName;
    String? lastName;
    String? phoneNumber;
    String? address;
    String? state;
    String? city;
    String? gender;
    String? dob;
    String? country;
    String? postalCode;
    bool?isDefault;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        gender: json["gender"],
        dob: json["dob"],
        country: json["country"],
        postalCode: json["postalCode"],
        isDefault: json["isDefault"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
        "state": state,
        "city": city,
        "gender": gender,
        "dob": dob,
        "country": country,
        "postalCode": postalCode,
        "isDefault": isDefault,
    };
}

class AddressCheckout {
    AddressCheckout({
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.address,
        this.state,
        this.city,
        this.gender,
        this.dob,
        this.country,
        this.postalCode,
    });

    String? firstName;
    String? lastName;
    String? phoneNumber;
    String? address;
    String? state;
    String? city;
    String? gender;
    String? dob;
    String? country;
    String? postalCode;

    factory AddressCheckout.fromJson(Map<String, dynamic> json) => AddressCheckout(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        gender: json["gender"],
        dob: json["dob"],
        country: json["country"],
        postalCode: json["postalCode"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
        "state": state,
        "city": city,
        "gender": gender,
        "dob": dob,
        "country": country,
        "postalCode": postalCode,
    };
}
