// Import library yang diperlukan dari Flutter
import 'package:flutter/material.dart';
import 'package:pegawai/model/employee.dart';
import 'dart:async';
import 'package:pegawai/Database/sql_helper.dart';

// Kelas MyEmployeeList merupakan StatefulWidget yang menampilkan daftar karyawan
class MyEmployeeList extends StatefulWidget {
  @override
  MyEmployeeListPageState createState() => MyEmployeeListPageState();
}

// Kelas MyEmployeeListPageState merupakan State dari MyEmployeeList
class MyEmployeeListPageState extends State<MyEmployeeList> {
// Future untuk menyimpan daftar karyawan dari database
  Future<List<Employee>>? employees;
// Variabel untuk menyimpan data inputan formulir
  late String firstname;
  late String lastname;
  late String mobileno;
// GlobalKey digunakan untuk mendapatkan akses ke widget Form dan Scaffold
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState(); // Memuat daftar karyawan saat widget pertama kali dibuat
    employees = fetchEmployeesFromDatabase();
  }

// Fungsi asinkron untuk mengambil daftar karyawan dari database
  Future<List<Employee>> fetchEmployeesFromDatabase() async {
// Membuat instance DBHelper untuk berinteraksi dengan database
    var dbHelper = DBHelper();
// Memanggil fungsi getEmployees dari DBHelper untuk mendapatkan daftar karyawan
    List<Employee> employeeList = await dbHelper.getEmployees();
// Mengembalikan daftar karyawan yang telah diperoleh dari database
    return employeeList;
  }

// Fungsi untuk menghapus data karyawan dari database dan memperbarui tampilan
  void deleteEmployee(Employee employee) async {
// Membuat instance DBHelper untuk berinteraksi dengan database
    var dbHelper = DBHelper();
// Memanggil fungsi deleteEmployee dari DBHelper untuk menghapus karyawan berdasarkan ID
    await dbHelper.deleteEmployee(employee.id!);
// Memperbarui tampilan dengan mengganti nilai variabel employees denganhasil fetchEmployeesFromDatabase
    setState(() {
      employees = fetchEmployeesFromDatabase();
    });
  }

// Fungsi untuk menampilkan dialog edit karyawan
  void editEmployee(Employee employee) {
// Menampilkan dialog edit karyawan
    showDialog(
      context: context,
// Mengonfigurasi widget yang akan ditampilkan dalam dialog
      builder: (BuildContext context) {
// Widget yang menampilkan dialog dengan judul dan konten
        return AlertDialog(
// Judul dialog
          title: Text('Edit Employee'),
// Untuk mengizinkan scroll jika kontennya lebih panjang dari layar
          content: SingleChildScrollView(
// Widget untuk mengelola formulir dan validasi
            child: Form(
              // Menggunakan kunci formKey untuk mengakses dan mengelola state dari form
              key: formKey,
              child: Column(
                children: [
// TextFormField untuk mengambil input First Name dari pengguna
                  TextFormField(
// Nilai awal diatur sesuai data karyawan yang ada
                    initialValue: employee.firstName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'First Name'),
// Validator untuk memastikan input tidak kosong
                    validator: (val) =>
                        val?.length == 0 ? "Enter First Name" : null,
// Menggunakan onSaved untuk menyimpan nilai input ke variabel firstname
                    onSaved: (val) => this.firstname = val!,
                  ),
// TextFormField untuk mengambil input Last Name dari pengguna
                  TextFormField(
                    initialValue: employee.lastName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Last Name'),
// Validator untuk memastikan input tidak kosong
                    validator: (val) =>
                        val?.length == 0 ? 'Enter Last Name' : null,
// Menggunakan onSaved untuk menyimpan nilai input ke variabel lastname
                    onSaved: (val) => this.lastname = val!,
                  ),
// TextFormField untuk mengambil input Mobile No dari pengguna
                  TextFormField(
                    initialValue: employee.mobileNo,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'Mobile No'),
// Validator untuk memastikan input tidak kosong
                    validator: (val) =>
                        val?.length == 0 ? 'Enter Mobile No' : null,
// Menggunakan onSaved untuk menyimpan nilai input ke variabel mobileno
                    onSaved: (val) => this.mobileno = val!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
// Tombol untuk membatalkan operasi
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
// Tombol untuk menyimpan perubahan data karyawan
            TextButton(
              onPressed: () {
                _submitEdit(employee.id!);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

// Fungsi untuk menyimpan perubahan data karyawan ke dalam database
  void _submitEdit(int id) {
// Melakukan validasi formulir sebelum menyimpan perubahan
    if (this.formKey.currentState!.validate()) {
// Menyimpan nilai formulir ke variabel firstname, lastname, dan mobileno
      formKey.currentState!.save();
// Jika validasi gagal, keluar dari fungsi
    } else {
      return null;
    }
// Membuat objek Employee baru dengan data yang diperoleh dari formulir
    final editedEmployee = new Employee(
      id: id,
      firstName: firstname,
      lastName: lastname,
      mobileNo: mobileno,
    );
// Membuat instance DBHelper untuk berinteraksi dengan database
    var dbHelper = DBHelper();
// Menyimpan perubahan ke dalam database
    dbHelper.saveEmployee(editedEmployee);
    Navigator.pop(context); // Menutup dialog edit
// Menampilkan snackbar untuk memberi informasi bahwa data berhasil diupdate
    _showSnackBar("Data updated successfully");
// Memperbarui tampilan dengan mengganti nilai variabel employees dengan hasil fetchEmployeesFromDatabase
    setState(() {
      employees = fetchEmployeesFromDatabase();
    });
  }

// Fungsi untuk menampilkan snackbar di bagian bawah layar
  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

// Membangun antarmuka pengguna
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
// Judul
        title: Text('Employee List'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Employee>>(
          future: employees,
          builder: (context, snapshot) {
// Jika data sudah diterima, menampilkan daftar karyawan
            if (snapshot.hasData) {
              return ListView.builder(
// Menentukan jumlah elemen dalam ListView sesuai dengan panjang data dari snapshot
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
// Mengambil satu objek karyawan dari daftar karyawan yang diterima dari database
                  Employee? employee = snapshot.data![index];
// Memastikan bahwa objek karyawan tidak null
                  if (employee != null) {
// Tampilkan detail karyawan dalam bentuk ListTile
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
// Menampilkan nama depan karyawan
                            Text(
                              employee.firstName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
// Menampilkan nama belakang karyawan
                            Text(
                              employee.lastName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
// Menampilkan nomor telepon karyawan
                            Text(
                              employee.mobileNo,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
// Tombol Edit
                            Container(
                              decoration: BoxDecoration(
                                shape:
                                    BoxShape.rectangle, // Agar bentuknya kotak
                                color: Colors.blue, // Ubah warna menjadi biru
                              ),
                              child: TextButton(
// Mengganti IconButton dengan TextButton
                                onPressed: () {
                                  editEmployee(employee);
                                },
                                child: Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
// Tombol Delete
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .rectangle, // Agar bentuknya lingkaran
                                color: Colors.blue, // Ubah warna menjadi biru
                              ),
                              child: TextButton(
// Mengganti IconButton dengan TextButton
                                onPressed: () {
                                  deleteEmployee(employee);
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink(); // Menghindari null employee
                  }
                },
              );
            } else if (snapshot.hasError) {
// Jika terjadi kesalahan, tampilkan pesan kesalahan
              return Text("${snapshot.error}");
            }
// Menampilkan indikator loading jika data masih diambil
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
