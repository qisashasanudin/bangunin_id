class MaterialModel {
  String materialId;
  String name;
  String size;
  String type;
  String unit;
  double price;
  int amount;
  String image;

  MaterialModel({
    this.materialId,
    this.name,
    this.size,
    this.type,
    this.unit,
    this.price,
    this.amount,
    this.image,
  });
}

List<MaterialModel> materials = [
  MaterialModel(
    name: 'semen',
    size: '50Kg',
    unit: 'sak',
    image: 'assets/img/materials/Semen_50kg.jpg',
  ),
  MaterialModel(
    name: 'MU200',
    size: '40Kg',
    unit: 'sak',
    image: 'assets/img/materials/MU_200_40kg.jpg',
  ),
  MaterialModel(
    name: 'besi',
    size: '6mm',
    type: 'polos',
    unit: 'batang',
    image: 'assets/img/materials/Besi_6_polos.jpg',
  ),
  MaterialModel(
    name: 'besi',
    size: '8mm',
    type: 'polos',
    unit: 'batang',
    image: 'assets/img/materials/Besi_8_polos.jpg',
  ),
  MaterialModel(
    name: 'besi',
    size: '13mm',
    type: 'ulir',
    unit: 'batang',
    image: 'assets/img/materials/Besi_13_ulir.jpg',
  ),
  MaterialModel(
    name: 'wiremesh',
    unit: 'lembar',
    image: 'assets/img/materials/Wiremesh.jpg',
  ),
  MaterialModel(
    name: 'genteng',
    unit: 'batang',
    image: 'assets/img/materials/Genteng.jpg',
  ),
  MaterialModel(
    name: 'bata',
    type: 'merah',
    unit: 'buah',
    image: 'assets/img/materials/Bata_merah.jpg',
  ),
  MaterialModel(
    name: 'bata',
    type: 'hebel',
    unit: 'buah',
    image: 'assets/img/materials/Bata_hebel.jpg',
  ),
  MaterialModel(
    name: 'keramik',
    type: 'lantai',
    unit: 'dus',
    image: 'assets/img/materials/Semen_50kg.jpg',
  ),
  MaterialModel(
    name: 'keramik',
    type: 'dinding',
    unit: 'dus',
    image: 'assets/img/materials/Keramik_lantai.jpg',
  ),
  MaterialModel(
    name: 'pintu',
    unit: 'buah',
    image: 'assets/img/materials/Pintu.jpg',
  ),
  MaterialModel(
    name: 'jendela',
    unit: 'm2',
    image: 'assets/img/materials/Jendela.jpg',
  ),
  MaterialModel(
    name: 'pintu ',
    type: 'toilet',
    unit: 'buah',
    image: 'assets/img/materials/Pintu_toilet.jpg',
  ),
  MaterialModel(
    name: 'cat',
    size: '25Kg',
    unit: 'pail',
    image: 'assets/img/materials/Cat_25kg.jpg',
  ),
  MaterialModel(
    name: 'waterproofing',
    unit: 'pail',
    image: 'assets/img/materials/Waterproofing.png',
  ),
  MaterialModel(
    name: 'sika',
    unit: 'pail',
    image: 'assets/img/materials/Sika.jpg',
  ),
  MaterialModel(
    name: 'lampu',
    unit: 'buah',
    image: 'assets/img/materials/Lampu.jpg',
  ),
  MaterialModel(
    name: 'kabel',
    unit: 'm',
    image: 'assets/img/materials/Kabel.jpg',
  ),
  MaterialModel(
    name: 'pipa',
    unit: 'batang',
    image: 'assets/img/materials/Pipa.jpg',
  ),
  MaterialModel(
    name: 'keran',
    unit: 'buah',
    image: 'assets/img/materials/Keran.jpg',
  ),
  MaterialModel(
    name: 'wastafel',
    unit: 'buah',
    image: 'assets/img/materials/Wastafel.jpg',
  ),
  MaterialModel(
    name: 'shower',
    unit: 'buah',
    image: 'assets/img/materials/Shower.jpg',
  ),
  MaterialModel(
    name: 'railing tangga',
    unit: 'm',
    image: 'assets/img/materials/Railing_tangga.jpg',
  ),
];
