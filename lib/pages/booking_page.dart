import 'package:flutter/material.dart';
import 'package:myapp/models/worker_model.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.worker});
  final WorkerModel worker;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
