import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice8/features/service_history/state/service_history_state.dart';
import 'package:flutter_practice8/shared/service_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/service_record_model.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  final serviceHistoryState = sl.get<ServiceHistoryState>();

  @override
  void initState() {
    super.initState();
    serviceHistoryState.addListener(_onStateChange);
  }

  @override
  void dispose() {
    serviceHistoryState.removeListener(_onStateChange);
    super.dispose();
  }

  void _onStateChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final serviceRecords = serviceHistoryState.serviceRecords;

    Widget mainContent = ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: serviceRecords.length,
      itemBuilder: (context, index) {
        final record = serviceRecords[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.build),
            title: Text(record.title),
            subtitle: Text(DateFormat('dd.MM.yyyy').format(record.date)),
            trailing: Text(
              '${record.cost.toStringAsFixed(2)} руб.',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );

    if (serviceRecords.isEmpty) {
      mainContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: "https://cdn-icons-png.flaticon.com/512/2621/2621723.png",
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Записей об обслуживании пока нет',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('История обслуживания'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.pushReplacement('/expenses'),
        ),
      ),
      body: mainContent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/history/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
