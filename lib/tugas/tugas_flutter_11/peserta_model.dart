class Peserta {
  int? id;
  String nama;
  String email;
  String noHp;
  String kota;
  String pelatihan;

  Peserta({
    this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.kota,
    required this.pelatihan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'noHp': noHp,
      'kota': kota,
      'pelatihan': pelatihan,
    };
  }

  factory Peserta.fromMap(Map<String, dynamic> map) {
    return Peserta(
      id: map['id'],
      nama: map['nama'],
      email: map['email'],
      noHp: map['noHp'],
      kota: map['kota'],
      pelatihan: map['pelatihan'],
    );
  }
}
