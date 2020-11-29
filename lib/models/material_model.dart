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
];
