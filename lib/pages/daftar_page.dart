import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/tugas_provider.dart';

enum FilterTugas { semua, aktif, selesai }

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  FilterTugas _filter = FilterTugas.semua; // state lokal

  @override
  Widget build(BuildContext context) {
    final semua = context.watch<TugasProvider>().daftar;
    final tampil = semua.where((t) {
      switch (_filter) {
        case FilterTugas.semua:
          return true;
        case FilterTugas.aktif:
          return !t.selesai;
        case FilterTugas.selesai:
          return t.selesai;
      }
    }).toList();

    // select: hanya dibangun ulang kalau jumlahAktif berubah
    final aktif = context.select((TugasProvider p) => p.jumlahAktif);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planner Tugas Kuliah'),
        actions: [
          IconButton(
            icon: Badge.count(
              count: aktif,
              isLabelVisible: aktif > 0,
              child: const Icon(Icons.bar_chart),
            ),
            onPressed: () => context.push('/statistik'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              children: FilterTugas.values.map((f) {
                return FilterChip(
                  label: Text(f.name[0].toUpperCase() + f.name.substring(1)),
                  selected: _filter == f,
                  onSelected: (_) => setState(() => _filter = f),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: tampil.isEmpty
                ? const Center(child: Text('Belum ada tugas'))
                : ListView.builder(
                    itemCount: tampil.length,
                    itemBuilder: (context, i) {
                      final t = tampil[i];
                      return ListTile(
                        leading: Checkbox(
                          value: t.selesai,
                          onChanged: (_) =>
                              context.read<TugasProvider>().tandaiSelesai(t.id),
                        ),
                        title: Text(
                          t.judul,
                          style: TextStyle(
                            decoration:
                                t.selesai ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: Text(
                          '${t.mataKuliah} • ${t.tenggat.day}/${t.tenggat.month}/${t.tenggat.year}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              context.read<TugasProvider>().hapus(t.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tambah'),
        child: const Icon(Icons.add),
      ),
    );
  }
}