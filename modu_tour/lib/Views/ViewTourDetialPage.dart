

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../Models/mTour.dart';

class ViewTourDetailPage extends StatefulWidget {
  final mTourData tourData;
  final int index;
  final DatabaseReference databaseReference;
  final String id;

  ViewTourDetailPage({required this.tourData, required this.index, required this.databaseReference, required this.id});

  @override
  State<ViewTourDetailPage> createState() => _ViewTourDetailPageState();
}

class _ViewTourDetailPageState extends State<ViewTourDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
