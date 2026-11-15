import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tugas_provider.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<TugasProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Statistik')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total tugas: ${p.total}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Selesai: ${p.jumlahSelesai}'),
            Text('Belum selesai: ${p.jumlahAktif}'),
            const SizedBox(height: 16),
            Text('Persentase selesai: ${p.persen.toStringAsFixed(0)}%'),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: p.persen / 100, minHeight: 10),
          ],
        ),
      ),
    );
  }
}