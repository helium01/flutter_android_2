class Bunga{
  final String id;
  final String id_kategori;
  final String nama_barang;
  final String foto;
  final String deskripsi;
  final String diskon;
  final String harga;
  final String stok;
  final String harga_akhir;
  final String nama_kategori;

  const Bunga({
    required this.id,
    required this.id_kategori,
    required this.nama_barang,
    required this.deskripsi,
    required this.diskon,
    required this.foto,
    required this.harga,
    required this.harga_akhir,
    required this.nama_kategori,
    required this.stok,
  });

  factory Bunga.fromJson(Map<String,dynamic>json){
    // print(json['nama_barang']);
    return Bunga(id: json['id'], id_kategori: json['id_kategori'], 
    nama_barang: json['nama_barang'], deskripsi: json['deskripsi'], diskon: json['diskon'], foto: json['foto'], 
    harga: json['harga'], harga_akhir: json['harga_akhir'], nama_kategori: json['nama_kategori'], stok: json['stok']);
  }
}
class Bunga2{
  final int id;
  final String id_kategori;
  final String nama_barang;
  final String kode_barang;
  final String foto;
  final String deskripsi;
  final String diskon;
  final String harga;
  final String stok;
  final String harga_akhir;

  const Bunga2({
    
    required this.id,
    required this.id_kategori,
    required this.nama_barang,
    required this.kode_barang,
    required this.deskripsi,
    required this.diskon,
    required this.foto,
    required this.harga,
    required this.harga_akhir,
    required this.stok,
  });

  factory Bunga2.fromJson(Map<String,dynamic>json){
    return Bunga2(id: json['id'], kode_barang: json['kode_barang'], id_kategori: json['id_kategori'], 
    nama_barang: json['nama_barang'], deskripsi: json['deskripsi'], diskon: json['diskon'], foto: json['foto'], 
    harga: json['harga'], harga_akhir: json['harga_akhir'], stok: json['stok']);
  }}
// bunga populer
class BungaPopuler{
  final int id;
  final String id_kategori;
  final String nama_barang;
  final String foto;
  final String deskripsi;
  final String diskon;
  final String harga;
  final String stok;
  final String harga_akhir;

  const BungaPopuler({
    required this.id,
    required this.id_kategori,
    required this.nama_barang,
    required this.deskripsi,
    required this.diskon,
    required this.foto,
    required this.harga,
    required this.harga_akhir,
    required this.stok,
  });

  factory BungaPopuler.fromJson(Map<String,dynamic>json){
    return BungaPopuler(id: json['id'], id_kategori: json['id_kategori'], 
    nama_barang: json['nama_barang'], deskripsi: json['deskripsi'], diskon: json['diskon'], foto: json['foto'], 
    harga: json['harga'], harga_akhir: json['harga_akhir'], stok: json['stok']);
  }
}

// rekomendasi
class BungaRekomendasi{
  final int id;
  final String id_kategori;
  final String nama_barang;
  final String foto;
  final String deskripsi;
  final String diskon;
  final String harga;
  final String stok;
  final String harga_akhir;

  const BungaRekomendasi({
    required this.id,
    required this.id_kategori,
    required this.nama_barang,
    required this.deskripsi,
    required this.diskon,
    required this.foto,
    required this.harga,
    required this.harga_akhir,
    required this.stok,
  });

  factory BungaRekomendasi.fromJson(Map<String,dynamic>json){
    return BungaRekomendasi(id: json['id'], id_kategori: json['id_kategori'], 
    nama_barang: json['nama_barang'], deskripsi: json['deskripsi'], diskon: json['diskon'], foto: json['foto'], 
    harga: json['harga'], harga_akhir: json['harga_akhir'], stok: json['stok']);
  }
}

class Kategori{
  final int id;
  final String nama_kategori;
  final String deskripsi;
  final String foto;

  const Kategori({
    required this.deskripsi,
    required this.foto,
    required this.id,
    required this.nama_kategori,
  });
  factory Kategori.fromJson(Map<String,dynamic>json){
    return Kategori(deskripsi: json['deskripsi'], foto: json['foto'], id: json['id'], nama_kategori: json['nama_kategori']);
  }
}
class Keranjang{
  final String id;
  final String id_barang;
  final String jumlah_keranjang;
  final String tgl_keranjang;
  final String status;
  final String id_user;
  final String foto;
  final String harga;
  final String nama_barang;

  const Keranjang({
    required this.id,
    required this.id_barang,
    required this.id_user,
    required this.jumlah_keranjang,
    required this.status,
    required this.foto,
    required this.nama_barang,
    required this.harga,
    required this.tgl_keranjang,
  });
  factory Keranjang.fromJson(Map<String, dynamic>json){
    // print(json);
    return Keranjang(id: json['id'], harga: json['harga'],  id_barang: json['id_barang'], id_user: json['id_user'], jumlah_keranjang: json['jumlah_keranjang'], status: json['status'], tgl_keranjang: json['tgl_keranjang'], nama_barang: json['nama_barang'],foto: json['foto']);
  }
}

class Checkoutt{
  final String id;
  final String id_barang;
  final String kode_barang;
  final String jumlah_keranjang;
  final String tgl_keranjang;
  final String status;
  final String id_user;
  final String foto;
  final String harga;
  final String harga_akhir;
  final String nama_barang;

  const Checkoutt({
    required this.id,
    required this.id_barang,
    required this.kode_barang,
    required this.id_user,
    required this.jumlah_keranjang,
    required this.status,
    required this.foto,
    required this.nama_barang,
    required this.harga,
    required this.harga_akhir,
    required this.tgl_keranjang,
  });
  factory Checkoutt.fromJson(Map<String, dynamic>json){
    print(json);
    return Checkoutt(id: json['id'], kode_barang: json['kode_barang'], harga: json['harga'], harga_akhir: json['harga_akhir'],  id_barang: json['id_barang'], id_user: json['id_user'], jumlah_keranjang: json['jumlah_keranjang'], status: json['status'], tgl_keranjang: json['tgl_keranjang'], nama_barang: json['nama_barang'],foto: json['foto']);
  }
}
class Kontak{
  final String id;
  final String nama;
  final String alamat;
  final String no_telp;
  final String email;
  final String deskripsi;
  final String kode_pos;
  final String logo;
  final String ak_instagram;

  const Kontak({
    required this.ak_instagram,
    required this.alamat,
    required this.deskripsi,
    required this.email,
    required this.id,
    required this.kode_pos,
    required this.logo,
    required this.nama,
    required this.no_telp
  });

  factory Kontak.fromJson(Map<String, dynamic>json){
    return Kontak(ak_instagram: json['ak_instagram'], alamat: json['alamat'], deskripsi: json['deskripsi'], email: json['email'], id: json['id'], kode_pos: json['kode_pos'], logo: json['logo'], nama: json['nama'], no_telp: json['no_telp']);
  }
}
class Profil{
    final String id;
    final String moto;
    final String foto_1;
    final String foto_2;
    final String foto_3;

    const Profil({
      required this.foto_1,
      required this.foto_2,
      required this.foto_3,
      required this.id,
      required this.moto,
    });

    factory Profil.fromJson(Map<String,dynamic>json){
      return Profil(moto:json['moto'],foto_1: json['foto_1'], foto_2: json['foto_2'], foto_3: json['foto_3'], id: json['id']);
    }
}
class Testimonii{
  final String id;
  final String name;
    final String id_user;
    final String id_barang;
    final String bintang;
    final String pesan;

    const Testimonii({
      required this.id_user,
      required this.id_barang,
      required this.bintang,
      required this.id,
      required this.pesan,
      required this.name,
    });

    factory Testimonii.fromJson(Map<String,dynamic>json){
      // print(json);
      return Testimonii(name:json['name'],
      pesan: json['pesan'], bintang: json['bintang'], id: json['id'], id_barang: json['id_barang'], id_user: json['id_user']);
    }
}
class Galeri{
   final int id;
    final String deskripsi;
    final String foto;

    const Galeri({
      required this.foto,
      required this.id,
      required this.deskripsi,
    });

     factory Galeri.fromJson(Map<String,dynamic>json){
      return Galeri(deskripsi:json['deskripsi'],foto: json['foto'], id: json['id']);
     }
}