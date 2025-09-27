import 'package:flutter/material.dart';

class AthleteData with ChangeNotifier {
  String fullName = '';
  int? age;
  double? weight;
  double? height;
  String city = '';
  String state = '';
  String gender = 'Male';

  void setAthleteData({
    required String fullName,
    required int? age,
    required double? weight,
    required double? height,
    required String city,
    required String state,
    required String gender,
  }) {
    this.fullName = fullName;
    this.age = age;
    this.weight = weight;
    this.height = height;
    this.city = city;
    this.state = state;
    this.gender = gender;
    notifyListeners();
  }

  void updateWeightAndHeight(double newWeight, double newHeight) {
    weight = newWeight;
    height = newHeight;
    notifyListeners();
  }
}