import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/daftar_page.dart';
import 'pages/statistik_page.dart';
import 'pages/tambah_page.dart';
import 'providers/tugas_provider.dart';

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DaftarPage()),
    GoRoute(path: '/tambah', builder: (context, state) => const TambahPage()),
    GoRoute(path: '/statistik', builder: (context, state) => const StatistikPage()),
  ],
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TugasProvider(),
      child: const PlannerApp(),
    ),
  );
}

class PlannerApp extends StatelessWidget {
  const PlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Planner Tugas Kuliah',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      routerConfig: _router,
    );
  }
}