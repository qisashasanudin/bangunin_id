class MaterialModel {
  String name;
  String size;
  String type;
  String unit;
  int price;
  String image;

  MaterialModel({
    this.name,
    this.size,
    this.type,
    this.unit,
    this.price,
    this.image,
  });
}

List<MaterialModel> materials = [
  MaterialModel(
    name: 'semen',
    size: '50Kg',
    unit: 'Sak',
  ),
  MaterialModel(
    name: 'MU200',
    size: '40Kg',
    unit: 'Sak',
  ),
  MaterialModel(
    name: 'besi',
    size: '6mm',
    type: 'polos',
    unit: 'batang',
  ),
  MaterialModel(
    name: 'besi',
    size: '8mm',
    type: 'polos',
    unit: 'batang',
  ),
  MaterialModel(
    name: 'besi',
    size: '13mm',
    type: 'ulir',
    unit: 'batang',
  ),
  MaterialModel(
    name: 'wiremesh',
    unit: 'lembar',
  ),
  MaterialModel(
    name: 'genteng',
    unit: 'batang',
  ),
  MaterialModel(
    name: 'bata',
    type: 'merah',
    unit: 'buah',
  ),
  MaterialModel(
    name: 'bata',
    type: 'hebel',
    unit: 'buah',
  ),
  MaterialModel(
    name: 'keramik',
    type: 'lantai',
    unit: 'dus',
  ),
  MaterialModel(
    name: 'keramik',
    type: 'dinding',
    unit: 'dus',
  ),
  MaterialModel(
    name: 'pintu',
    unit: 'buah',
  ),
  MaterialModel(
    name: 'jendela',
    unit: 'm2',
  ),
  MaterialModel(
    name: 'pintu ',
    type: 'toilet',
    unit: 'buah',
  ),
  MaterialModel(
    name: 'cat',
    size: '25Kg',
    unit: 'pail',
  ),
  MaterialModel(
    name: 'waterproofing',
    unit: 'pail',
  ),
  MaterialModel(
    name: 'sika',
    unit: 'pail',
  ),
  MaterialModel(
    name: 'lampu',
    unit: 'buah',
  ),
  MaterialModel(
    name: 'kabel',
    unit: 'm',
  ),
  MaterialModel(
    name: 'pipa',
    unit: 'batang',
  ),
  MaterialModel(
    name: 'keran',
    unit: 'buah',
  ),
  MaterialModel(
    name: 'wastafel',
    unit: 'buah',
  ),
  MaterialModel(
    name: 'shower',
    unit: 'buah',
  ),
  MaterialModel(
    name: 'railing tangga',
    unit: 'm',
  ),
];