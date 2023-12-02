// import 'package:flutter/material.dart';
// import 'package:praktikum9/sql_helper.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Notes App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Notes'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController judulController = TextEditingController();
//   TextEditingController deskripsiController = TextEditingController();

//   // READ
//   List<Map<String, dynamic>> catatan = [];

//   void refreshCatatan() async {
//     final data = await SQLHelper.getCatatan();
//     setState(() {
//       catatan = data;
//     });
//   }

//   @override
//   void initState() {
//     refreshCatatan();
//     super.initState();
//   }

//   // CREATE
//   Future<void> tambahCatatan() async {
//     await SQLHelper.tambahCatatan(judulController.text, deskripsiController.text);
//     refreshCatatan();
//   }

//   // DELETE
//   Future<void> hapusCatatan(int id) async {
//     await SQLHelper.hapusCatatan(id);
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Berhasil dihapus")));
//     refreshCatatan();
//   }

//   // UPDATE
//   Future<void> ubahCatatan(int id) async {
//     await SQLHelper.ubahCatatan(id, judulController.text, deskripsiController.text);
//     refreshCatatan();
//   }

//   void modalForm(int? id) {
//   if (id != null) {
//     final dataCatatan = catatan.firstWhere((item) => item['id'] == id);

//     judulController.text = dataCatatan['judul'];
//     deskripsiController.text = dataCatatan['deskripsi'];
//   } else {
//     judulController.text = '';
//     deskripsiController.text = '';
//   }

//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(15),
//         width: double.infinity,
//         height: 800,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: judulController,
//                 decoration: const InputDecoration(hintText: "Judul"),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: deskripsiController,
//                 decoration: const InputDecoration(hintText: "Deskripsi"),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (id == null) {
//                     await tambahCatatan();
//                     print("Add");
//                   } else {
//                     print("Updated");
//                     await ubahCatatan(id);
//                   }
//                   judulController.text = '';
//                   deskripsiController.text = '';
//                   Navigator.pop(context);
//                 },
//                 child: Text(id == null ? 'Add' : 'Change'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//         itemCount: catatan.length,
//         itemBuilder: (context, index) => Card(
//           child: ListTile(
//             title: Text(catatan[index]['title']),
//             subtitle: Text(catatan[index]['description']),
//             trailing: SizedBox(
//               width: 100,
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => modalForm(catatan[index]['id']),
//                     icon: Icon(Icons.edit),
//                   ),
//                   IconButton(
//                     onPressed: () => hapusCatatan(catatan[index]['id']),
//                     icon: Icon(Icons.delete),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => modalForm(null),
//         tooltip: 'Add',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:praktikum9/sql_helper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Todo List',
      home: const MyHomePage(title: 'Todo List Alia'),
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

  List<Map<String, dynamic>> catatan = [];

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

  Future<void> tambahCatatan() async {
    await SQLHelper.tambahCatatan(
        judulController.text, deskripsiController.text);
    refreshCatatan();
  }

  Future<void> hapusCatatan(int id) async {
    await SQLHelper.hapusCatatan(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Berhasil Dihapus"),
    ));
    refreshCatatan();
  }

  Future<void> ubahCatatan(int id) async {
    await SQLHelper.ubahCatatan(
        id, judulController.text, deskripsiController.text);
    refreshCatatan();
  }

  void modalForm(id) async {
    if (id != null) {
      final dataCatatan = catatan.firstWhere((item) => item['id'] == id);

      judulController.text = dataCatatan['judul'];
      deskripsiController.text = dataCatatan['deskripsi'];
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
                decoration: const InputDecoration(hintText: "Judul"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(hintText: "Deskripsi"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await tambahCatatan();
                    print("Add");
                  } else {
                    print("Update");
                    await ubahCatatan(id);
                  }
                  judulController.text = '';
                  deskripsiController.text = '';
                  Navigator.pop(context);
                },
                child: Text(id == null ? 'Add' : 'Ubah'),
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
            title: Text(catatan[index]['judul']),
            subtitle: Text(catatan[index]['deskripsi']),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => modalForm(catatan[index]['id']),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      hapusCatatan(catatan[index]['id']);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
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
