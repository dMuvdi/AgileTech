import 'package:agile_tech/controllers/home_page_controller.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/equipment_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(HomePageController());

    return GetBuilder<HomePageController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Agile',
                      style: TextStyle(
                        fontFamily: FontFamilyToken.montserrat,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Tech',
                      style: TextStyle(
                        fontFamily: FontFamilyToken.montserrat,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF670F0F),
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
            backgroundColor: const Color(0xFFFF5454),
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 160,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5454),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25.0, right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.role,
                      style: const TextStyle(
                        fontFamily: FontFamilyToken.montserrat,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF670F0F),
                      ),
                    ),
                    Text(
                      'Hola, ${controller.name}',
                      style: const TextStyle(
                        fontFamily: FontFamilyToken.montserrat,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 4), // changes the position of the shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: const FittedBox(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('23', style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 28, fontWeight: FontWeight.w700),),
                                  Text('Total de equipos', style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 10, fontWeight: FontWeight.w400),)
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('13', style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 28, fontWeight: FontWeight.w700),),
                                  Text('Total Mecánicos', style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 10, fontWeight: FontWeight.w400),)
                                ],
                              ),
                            ), 
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('10', style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 28, fontWeight: FontWeight.w700),),
                                  Text('Total Eléctricos',style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 10, fontWeight: FontWeight.w400),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      'Añadidos recientemente',
                      style: TextStyle(
                        fontFamily: FontFamilyToken.montserrat,
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 365,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                        child: EquipmentCard(
                          name: 'Manguera Industrial', 
                          category: 'Mecánico', 
                          stock: 10,
                          imageUrl: 'https://proveedorindustrialonline.com/wp-content/uploads/2020/11/manguera-industria.png'
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
          // body: GetBuilder<HomePageController>(
          //   id: 'home',
          //   builder: (context) {
          //     return Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           'Hello, ${controller.name}',
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //         Text(
          //           'Token: ${controller.token}',
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       ],
          //     );
          //   }
          // ),
        );
      }
    );
  }
}