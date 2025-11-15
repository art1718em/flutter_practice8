import 'package:flutter/material.dart';
import '../models/service_record_model.dart';

class ServiceHistoryState extends ChangeNotifier {
  final List<ServiceRecordModel> _serviceRecords = [];

  List<ServiceRecordModel> get serviceRecords => _serviceRecords;

  void addServiceRecord(String title, double cost) {
    final newRecord = ServiceRecordModel(
      title: title,
      cost: cost,
      date: DateTime.now(),
    );
    _serviceRecords.add(newRecord);
    notifyListeners();
  }
}
