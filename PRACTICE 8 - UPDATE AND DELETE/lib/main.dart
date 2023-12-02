import 'package:flutter/material.dart';
import 'package:pegawai/database/dbhelper.dart';
import 'package:pegawai/employeelist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Pegawai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Daftar Pegawai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String firstname;
  late String lastname;
  late String mobileno;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Saving Employee'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: 'Next Choice',
            onPressed: () {
              navigateToEmployeeList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Nama Depan'),
                validator: (val) =>
                    val?.length == 0 ? "Masukkan Nama Depan" : null,
                onSaved: (val) => this.firstname = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Nama Belakang'),
                validator: (val) =>
                    val?.length == 0 ? 'Masukkan Nama Belakang' : null,
                onSaved: (val) => this.lastname = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Nomor Handphone'),
                validator: (val) =>
                    val?.length == 0 ? 'Masukkan Nomor Handphone' : null,
                onSaved: (val) => this.mobileno = val!,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text('Save Employee'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    } else {
      return null;
    }

    final dbHelper = DBHelper();
    dbHelper.saveEmployee(firstname, lastname, mobileno);
    _showSnackBar("Data berhasil disimpan");

    // Setelah menyimpan, bersihkan formulir
    formKey.currentState!.reset();
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  void navigateToEmployeeList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEmployeeList()),
    );
  }
}
