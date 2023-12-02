
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prak11/sql_helper.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alia Dewanto Todo List',
      home: const MyHomePage(title: 'Alia Dewanto-Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController gambarController = TextEditingController();

  List<Map<String, dynamic>> catatan = [];
  Map<String, dynamic>? catatanDihapus;

  void refreshCatatan() async {
    final data = await SQLHelper.getCatatan();
    setState(() {
      catatan = data;
    });
  }

  @override
  void initState() {
    refreshCatatan();
    super.initState();
  }

  Future<void> _ambilGambar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        gambarController.text = pickedFile.path;
      });
    }
  }

  Future<void> tambahCatatan(String judul, String deskripsi, String gambar) async {
    await SQLHelper.tambahCatatan(judul, deskripsi, gambar);
    refreshCatatan();
  }

  Future<void> hapusCatatan(int id) async {
    catatanDihapus = catatan.firstWhere((item) => item['id'] == id);
    await SQLHelper.hapusCatatan(id);

    refreshCatatan();
  }

  Future<void> ubahCatatan(int id, String judul, String deskripsi, String gambar) async {
    await SQLHelper.ubahCatatan(id, judul, deskripsi, gambar);
    refreshCatatan();
  }

  void modalForm(int? id) async {
    if (id != null) {
      final dataCatatan = catatan.firstWhere((item) => item['id'] == id);

      judulController.text = dataCatatan['judul'];
      deskripsiController.text = dataCatatan['deskripsi'];
      gambarController.text = dataCatatan['gambar'];
    }
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: 800,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: judulController,
                decoration: const InputDecoration(hintText: "masukkan judul"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(hintText: "masukkan deskripsi"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: gambarController,
                decoration: const InputDecoration(hintText: "masukkan url gambar"),
              ),
              ElevatedButton(
                onPressed: _ambilGambar,
                child: const Text("pilih gambar"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await tambahCatatan(judulController.text, deskripsiController.text, gambarController.text);
                    print("tambah");
                  } else {
                    print("update");
                    await ubahCatatan(id, judulController.text, deskripsiController.text, gambarController.text);
                  }
                  judulController.text = '';
                  deskripsiController.text = '';
                  gambarController.text = '';
                  Navigator.pop(context);
                  refreshCatatan();
                },
                child: Text(id == null ? 'Tambah' : 'Ubah'),
              ),
            ],
          ),
        ),
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: ListView.builder(
      itemCount: catatan.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(catatan[index]['gambar']),
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          catatan[index]['judul'],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(catatan[index]['deskripsi']),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0), // Atur padding ke bawah ikon
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => modalForm(catatan[index]['id']),
                          icon: const Icon(Icons.edit),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            hapusCatatan(catatan[index]['id']);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        modalForm(null);
      },
      tooltip: 'Tambah Catatan',
      child: const Icon(Icons.add),
    ),
  );
}
}