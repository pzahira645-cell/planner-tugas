import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/tugas_provider.dart';

class TambahPage extends StatefulWidget {
  const TambahPage({super.key});

  @override
  State<TambahPage> createState() => _TambahPageState();
}

class _TambahPageState extends State<TambahPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulCtrl;
  late final TextEditingController _mkCtrl;
  DateTime? _tenggat;

  @override
  void initState() {
    super.initState();
    _judulCtrl = TextEditingController();
    _mkCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _judulCtrl.dispose(); // wajib dibersihkan!
    _mkCtrl.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tenggat ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (!mounted) return; // cek mounted setelah await
    if (hasil != null) setState(() => _tenggat = hasil);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    if (_tenggat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tenggat dulu ya')),
      );
      return;
    }
    context.read<TugasProvider>().tambah(
          judul: _judulCtrl.text.trim(),
          mataKuliah: _mkCtrl.text.trim(),
          tenggat: _tenggat!,
        );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulCtrl,
                decoration: const InputDecoration(labelText: 'Judul tugas'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _mkCtrl,
                decoration: const InputDecoration(labelText: 'Mata kuliah'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Mata kuliah wajib diisi'
                    : null,
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(_tenggat == null
                    ? 'Belum pilih tenggat'
                    : 'Tenggat: ${_tenggat!.day}/${_tenggat!.month}/${_tenggat!.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pilihTanggal,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _simpan,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}