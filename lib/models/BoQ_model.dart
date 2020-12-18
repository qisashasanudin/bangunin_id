class BoQModel {
  String attributeId;
  String name;
  String unit;
  int amount;

  BoQModel({
    String attributeId,
    String name,
    String unit,
    int amount,
  })  : this.attributeId = attributeId,
        this.name = name ?? '',
        this.unit = unit ?? '',
        this.amount = amount;
}

class BoQCategoryModel {
  String categoryName;
  List contents;

  BoQCategoryModel({
    String categoryName,
    List<BoQModel> contents,
  })  : this.categoryName = categoryName,
        this.contents = contents;
}

List<BoQCategoryModel> boqDataset = [
  BoQCategoryModel(categoryName: 'Persiapan', contents: [
    BoQModel(
      name: 'Koordinasi Keamanan',
      unit: 'ls',
    ),
    BoQModel(
      name: 'Pembersihan Lokasi',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Uragan Tanah',
      unit: 'm3',
    ),
    BoQModel(
      name: 'Mobilisasi dan demobilisasi',
      unit: 'ls',
    ),
    BoQModel(
      name: 'Bedeng Tukang',
      unit: 'ls',
    ),
  ]),
  BoQCategoryModel(categoryName: 'Struktur Bangunan', contents: [
    BoQModel(
      name: 'Galian Tanah pondasi',
      unit: 'm3',
    ),
    BoQModel(
      name: 'Galian Tanah Sloof',
      unit: 'm3',
    ),
    BoQModel(
      name: 'Pasir urug bawah fondasi t = 5 cm',
      unit: 'm3',
    ),
    BoQModel(
      name: 'Pasir urug bawah sloof t = 5 cm',
      unit: 'm3',
    ),
    BoQModel(
      name: 'Kolom beton Bertulang K1',
      unit: 'm3',
    ),
  ]),
  BoQCategoryModel(categoryName: 'Dinding', contents: [
    BoQModel(
      name: 'Pekerjaan Dinding Lantai 1',
      unit: 'judul',
    ),
    BoQModel(
      name: 'Pasangan bata (1 : 2)',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasangan bata roster',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Plester (1 : 3)',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Acian',
      unit: 'm2',
    ),
  ]),
  BoQCategoryModel(categoryName: 'Lantai, Plafon, Jendela Pintu', contents: [
    BoQModel(name: 'LANTAI 1', unit: 'judul'),
    BoQModel(
      name: 'Rangka Plafond Besi Holo',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Plafond gypsum 9 mm',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Lis Plafond Gypsum 15 cm',
      unit: 'm',
    ),
    BoQModel(
      name: 'Pasang Plin keramik',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Keramik Teras Depan',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Plin keramik',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Keramik Toilet',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Plin keramik',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Keramik Gudang',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Plin keramik',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Keramik R. Keluarga',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Plin keramik',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Keramik Teras Belakang',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pasang Plin keramik',
      unit: 'm2',
    ),
  ]),
  BoQCategoryModel(categoryName: 'Toilet', contents: [
    BoQModel(name: 'Pekerjaan Toilet LT 1 (2 Ruang)', unit: 'judul'),
    BoQModel(
      name: 'Pasang Keramik Dinding',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Closet Duduk Toto Standart',
      unit: 'set',
    ),
    BoQModel(
      name: 'Wastafel Toto Standart',
      unit: 'bh',
    ),
    BoQModel(
      name: 'Stop Kran Toto',
      unit: 'bh',
    ),
  ]),
  BoQCategoryModel(categoryName: 'Atap', contents: [
    BoQModel(name: 'Atap', unit: 'judul'),
    BoQModel(
      name: 'Rangka atap baja ringan',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Penutup atap genteng utama',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Pek. Dak talang dan topian',
      unit: 'm3',
    ),
  ]),
  BoQCategoryModel(categoryName: 'Plumbing', contents: [
    BoQModel(name: 'Instalasi Air Hujan', unit: 'judul'),
    BoQModel(
      name: 'Talang PVC 4" diameter',
      unit: 'm2',
    ),
    BoQModel(
      name: 'RD (Roof Drain) 4"',
      unit: 'm2',
    ),
    BoQModel(name: 'Instalasi Air Kotor', unit: 'judul'),
    BoQModel(
      name: 'PVC pipe class AW ex. Wavin 4" diameter',
      unit: 'm',
    ),
    BoQModel(
      name: 'PVC pipe class AW ex. Wavin 3" diameter',
      unit: 'm2',
    ),
    BoQModel(
      name: 'PVC pipe class AW ex. Wavin 1 1/2" diameter',
      unit: 'm2',
    ),
  ]),
  BoQCategoryModel(categoryName: 'Listrik', contents: [
    BoQModel(name: 'Pekerjaan listrik', unit: 'judul'),
    BoQModel(
      name: 'Instalasi titik lampu downlight 4"',
      unit: 'titik',
    ),
    BoQModel(
      name: 'Instalasi stop kontak Panasonic',
      unit: 'titik',
    ),
    BoQModel(
      name: 'jaringan MCB',
      unit: 'bh',
    ),
    BoQModel(
      name: 'Box panel listrik',
      unit: 'bh',
    ),
  ]),
  BoQCategoryModel(categoryName: 'Lain-lain', contents: [
    BoQModel(name: 'lain-lain', unit: 'judul'),
    BoQModel(
      name: 'Rumput gajah mini',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Anti rayap',
      unit: 'm2',
    ),
    BoQModel(
      name: 'Paving Block',
      unit: 'm2',
    ),
  ]),
];
