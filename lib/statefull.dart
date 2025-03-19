import 'package:flutter/material.dart';

class Statefull extends StatefulWidget {
  const Statefull({super.key});

  @override
  State<Statefull> createState() => _StatefullState();
}

class _StatefullState extends State<Statefull> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}