// class Employee {
//   final int? id;
//   final String firstName;
//   final String lastName;
//   final String mobileNo;

//   const Employee({
//     this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.mobileNo});

//   static Employee fromMap(Map<String, Object?> map) => Employee(
//     firstName : map["firstname"] as String,
//     lastName : map["lastname"] as String,
//     mobileNo : map["mobileno"] as String,
//   );

// }
// Kelas Employee merepresentasikan model data untuk entitas karyawan
class Employee {
// Properti id dapat bernilai null karena akan diisi oleh database
  int? id;
// Properti firstName, lastName, dan mobileNo yang wajib diisi
  String firstName;
  String lastName;
  String mobileNo;
// Konstruktor untuk membuat objek Employee
  Employee({
    this.id, // ID karyawan (opsional)
    required this.firstName, // Nama depan karyawan (wajib)
    required this.lastName, // Nama belakang karyawan (wajib)
    required this.mobileNo, // Nomor telepon karyawan (wajib)
  });
// Fungsi toMap digunakan untuk mengonversi objek Employee ke dalam bentuk Map yang sesuai untuk penyimpanan dalam database
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID karyawan
      'first_name': firstName, // Nama depan karyawan
      'last_name': lastName, // Nama belakang karyawan
      'mobile_no': mobileNo, // Nomor telepon karyawan
    };
  }

// Factory constructor fromMap digunakan untuk membuat objek Employee dari Map yang diperoleh dari database
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'], // Mendapatkan ID dari Map
      firstName: map['first_name'], // Mendapatkan nama depan dari Map
      lastName: map[
          'last_name'], // Mendapatkan nama belakang dari MapmobileNo: map['mobile_no'], // Mendapatkan nomor telepon dari Map
    );
  }
}
