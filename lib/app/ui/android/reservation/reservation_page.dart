import 'package:flutter/material.dart';

class ReservationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Reservas do cliente'),
      ),
    );
  }
}
