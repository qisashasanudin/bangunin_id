class ShopMaterialModel {
  String name;
  String type;
  String shortDesc;
  String desc;
  String image;
  int rate;
  int price;

  ShopMaterialModel(
      {this.name,
      this.type,
      this.shortDesc,
      this.desc,
      this.image,
      this.rate,
      this.price});
}

List<ShopMaterialModel> menu = [
  ShopMaterialModel(
      name: "Pasir",
      type: 'Hot',
      shortDesc: "Esspresso dengan rasa lebih mild",
      desc:
          "Kamu pasti selalu menemukan cappuccino dalam buku menu tiap kali pergi ke kedai kopi, atau bahkan kafe-kafe biasa. Cappuccino adalah olahan espresso yang paling banyak digemari, terutama bagi penikmat kopi dengan rasa lebih mild",
      image: "assets/placeholders/cappuccino.jpg",
      rate: 5,
      price: 22000),
  ShopMaterialModel(
      name: "Keramik",
      type: "Hot",
      shortDesc: "Espresso dengan milky dan gurih.",
      desc:
          "Kalau kamu gak terlalu menikmati kopi yang cenderung pahit, kamu bisa pesan macchiato sebagai alternatif. Rasio steamed milk dalam minuman ini lebih besar dari espresso, sehingga ada sentuhan milky dan gurih.",
      image: "assets/placeholders/Macchiato.jpg",
      rate: 5,
      price: 22000),
  ShopMaterialModel(
      name: "Batu Bata",
      type: "Hot",
      shortDesc: "Batu bata dengan warna merah",
      desc:
          "Minuman kopi paling dasar ini biasanya disajikan dalam demitasse alias cangkir khusus espresso berukuran 30 mililiter (satu shot) sampai 118 mililiter. Espresso bertekstur pekat dan pahit, dengan buih putih alias crema di atasnya yang terbentuk dari tekanan minyak dalam bijih kopi.",
      image: "assets/placeholders/espreso.jpg",
      rate: 5,
      price: 12000),
  ShopMaterialModel(
      name: "Semen",
      type: "Hot",
      shortDesc: "Espresso dengan air panas",
      desc:
          "Americano terdiri dari satu shot espresso yang dituangkan dalam cangkir berukuran 178 mililiter yang dicampur dengan air panas hingga memenuhi gelas. Jenis lainnya adalah doppio, yakni segelas Americano dengan dua shot espresso. Minuman ini kerap disajikan dalam panas maupun dingin yang disebut iced Americano.",
      image: "assets/placeholders/americano.jpg",
      rate: 5,
      price: 15000),
  ShopMaterialModel(
      name: "Cat",
      type: "Hot",
      shortDesc: "Espresso dengan air panas",
      desc:
          "Americano terdiri dari satu shot espresso yang dituangkan dalam cangkir berukuran 178 mililiter yang dicampur dengan air panas hingga memenuhi gelas. Jenis lainnya adalah doppio, yakni segelas Americano dengan dua shot espresso. Minuman ini kerap disajikan dalam panas maupun dingin yang disebut iced Americano.",
      image: "assets/placeholders/espreso.jpeg",
      rate: 5,
      price: 15000),
  ShopMaterialModel(
      name: "Kayu",
      type: "Hot",
      shortDesc: "Espresso dengan air panas",
      desc:
          "Americano terdiri dari satu shot espresso yang dituangkan dalam cangkir berukuran 178 mililiter yang dicampur dengan air panas hingga memenuhi gelas. Jenis lainnya adalah doppio, yakni segelas Americano dengan dua shot espresso. Minuman ini kerap disajikan dalam panas maupun dingin yang disebut iced Americano.",
      image: "assets/placeholders/header.jpg",
      rate: 5,
      price: 15000),
];
