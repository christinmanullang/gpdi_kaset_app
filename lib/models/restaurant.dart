import 'package:flutter/material.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [
    // SENIN
    Food(
      name: 'name',
      description:
          "HIDUP YANG KEKAL 'Dan Aku tahu, bahwa perintah-Nya itu adalah hidup yang kekal. Jadi apa yang Aku katakan, Aku menyampaikannya sebagaimana yang difirmankan oleh Bapa kepada-Ku.' Masuk dalam Kerajaan Sorga adalah tujuan akhir hidup orang percaya.  Tetapi, untuk bisa mencapai tujuan tersebut ada harga yang harus dibayar, yaitu taat melakukan firman Tuhan. Menjadi pelaku firman adalah syarat utama untuk mendapatkan kehidupan kekal;  sebaliknya ketidaktaatan terhadap firman Tuhan berujung pada penghukuman kekal, sebab ada tertulis:  '...upah dosa ialah maut;' Roma 6:23.  Rasul Paulus menyatakan bahwa firman Tuhan bermanfaat untuk mengajar, untuk menyatakan kesalahan, untuk memperbaiki kelakuan dan untuk mendidik orang dalam kebenaran.  2 Timotius 3:16 Maka dari itu jangan marah atau tersinggung bila tertegur oleh firman Tuhan yang keras.  Lebih baik kita merasakan  'sakit'  sekarang saat berada di dunia daripada mengalami kebinasaan kekal.  Jika dalam kondisi yang baik mungkin kita bisa melakukan apa yang Tuhan perintahkan.Ketika banyak pergumulan seringkali kita merasa berat untuk melakukan kehendak Tuhan, terlebih-lebih bila perintah Tuhan itu sepertinya tidak masuk akal. Apakah kita mengasihi Tuhan?  Bukti kasih kepada Tuhan adalah taat melakukan firman-Nya!  'Jika seorang mengasihi Aku, ia akan menuruti firman-Ku dan Bapa-Ku akan mengasihi dia dan Kami akan datang kepadanya dan diam bersama-sama dengan dia. Barangsiapa tidak mengasihi Aku, ia tidak menuruti firman-Ku;' Yohanes 14:23-24.Perintah Tuhan adalah hidup yang kekal!  Oleh karena itu jangan pandang remeh firman Tuhan!  'Siapa meremehkan firman, ia akan menanggung akibatnya, tetapi siapa taat kepada perintah, akan menerima balasan.' Amsal 13:13. Hidup menyimpang dari firman Tuhan resikonya sangat besar, dampaknya bukan hanya untuk kehidupan di dunia ini saja, tapi juga untuk kehidupan di kekekalan Maka  '...janganlah menyimpang ke kanan atau ke kiri, supaya engkau beruntung, ke manapun engkau pergi.'  Yosua 1:7.  Ketaatan terhadap firman Tuhan itulah yang membawa kepada kehidupan kekal!Selamat pagi Selamat Beraktivitas Tuhan Yesus Memberkati",
      imagePath: 'assets/images/bible.png',
      price: 10.0,
      category: FoodCategory.Senin,
      availableAddons: [Addon(name: 'name', price: 10)],
    ),
    Food(
      name: 'name',
      description: 'description',
      imagePath: 'assets/images/bible.png',
      price: 10.0,
      category: FoodCategory.Selasa,
      availableAddons: [Addon(name: 'name', price: 10)],
    ),
    Food(
      name: 'name',
      description: 'description',
      imagePath: 'assets/images/bible.png',
      price: 10.0,
      category: FoodCategory.Rabu,
      availableAddons: [Addon(name: 'name', price: 10)],
    ),
    Food(
      name: 'name',
      description: 'description',
      imagePath: 'assets/images/bible.png',
      price: 10.0,
      category: FoodCategory.Kamis,
      availableAddons: [Addon(name: 'name', price: 10)],
    ),
    Food(
      name: 'name',
      description: 'description',
      imagePath: 'assets/images/bible.png',
      price: 10.0,
      category: FoodCategory.Jumat,
      availableAddons: [Addon(name: 'name', price: 10)],
    ),
  ];

  List<Food> get menu => _menu;
}
