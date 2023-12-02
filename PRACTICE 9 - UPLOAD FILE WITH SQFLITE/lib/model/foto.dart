// class Foto {
//   final int? id;
//   final String judul;
//   final String deskripsi;
//   final String photo;

//   const Foto({
//     this.id,
//     required this.judul,
//     required this.deskripsi,
//     required this.photo,
//   });

//   Map<String, dynamic> toList() {
//     return {'id': id, 'judul': judul, 'deskripsi': deskripsi, 'photo': photo};
//   }

//   @override
//   String toString() {
//     return "{'id': id, 'judul': 'judul', 'deskripsi': 'deskripsi', 'photo': 'photo'}";
//   }
// }
class Foto {
  late int id;
  late String judul;
  late String deskripsi;
  late String gambar;

  Foto({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.gambar,
  });
}
