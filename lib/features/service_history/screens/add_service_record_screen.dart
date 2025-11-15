import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_practice8/features/service_history/state/service_history_state.dart';
import 'package:flutter_practice8/shared/service_locator.dart';
import 'package:go_router/go_router.dart';

class AddServiceRecordScreen extends StatefulWidget {
  const AddServiceRecordScreen({super.key});

  @override
  State<AddServiceRecordScreen> createState() => _AddServiceRecordScreenState();
}

class _AddServiceRecordScreenState extends State<AddServiceRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _costController = TextEditingController();

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final cost = double.tryParse(_costController.text) ?? 0.0;

      if (sl.isRegistered<ServiceHistoryState>()) {
        final serviceHistoryState = sl.get<ServiceHistoryState>();
        serviceHistoryState.addServiceRecord(title, cost);
        context.pop();
      } else {
        debugPrint('Ошибка: ServiceHistoryState не зарегистрирован в GetIt!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Service Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Service Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Cost',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cost';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Save Service Record'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
