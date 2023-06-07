import 'dart:developer';

import 'package:crud/read.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intro_slider/intro_slider.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    
    listContentConfig.add(
      const ContentConfig(
        title: "Welcome",
        description:
            "Selamat datang di aplikasi ini, geser ke kiri untuk cara menggunakan aplikasi",
        pathImage: "images/SINGGI.jpg",
        backgroundColor: Color(0xff203152),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "1",
        description:
            "Pada Halaman Pertama kita dapat melihat list user yang telah di ambil dari API reqres.in",
        pathImage: "images/page2.jpg",
        backgroundColor: Color(0xff9932CC),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "2",
        description:
            "Untuk pergi ke halaman edit dapat menekan icon pensil di samping data user, jika ingin menghapus data tekan icon tempat sampah, dan tombol dipojok kanan bawah untuk ke halaman tambah user",
        pathImage: "images/page2.jpg",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "3",
        description:
            "Pada Halaman Edit kita dapat mengubah nama dan job dengan mengisi textfield lalu menekan tombol update",
        pathImage: "images/page3.jpg",
        backgroundColor: Color(0xff203152),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "4",
        description:
            "Pada halaman Create User kita dapat mengisi kolom nama dan juga pekerjaan, lalu menekan tombol save, setelah itu data yang telah di save akan muncul dibawahnya",
            pathImage: "images/page4.jpg",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Read();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
    );
  }
}