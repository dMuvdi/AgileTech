import 'package:agile_tech/controllers/home_page_controller.dart';
import 'package:agile_tech/screens/create_equipment_screen.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/equipment_card.dart';
import 'equipment_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(HomePageController());

    return GetBuilder<HomePageController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
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
                controller.role == "Administrador" ? IconButton(
                  onPressed: () {
                    Get.to(() => const CreateEquipmentScreen(), transition: Transition.rightToLeft);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ) :  const SizedBox()
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FittedBox(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('${controller.equipments.length}', style: const TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 28, fontWeight: FontWeight.w700),),
                                  const Text('Total de equipos', style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 10, fontWeight: FontWeight.w400),)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('${controller.getAmountOfEquipments('Mecánico')}', style: const TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 28, fontWeight: FontWeight.w700),),
                                  const Text('Total Mecánicos', style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 10, fontWeight: FontWeight.w400),)
                                ],
                              ),
                            ), 
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('${controller.getAmountOfEquipments('Eléctrico')}', style: const TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 28, fontWeight: FontWeight.w700),),
                                  const Text('Total Eléctricos',style: TextStyle(fontFamily: FontFamilyToken.montserrat, fontSize: 10, fontWeight: FontWeight.w400),)
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
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: controller.equipments.isEmpty ? Alignment.center : Alignment.bottomCenter,
                child: SizedBox(
                  width: controller.equipments.isEmpty ?  30 : double.infinity,
                  height: controller.equipments.isEmpty ?  30 : 365,
                  child: controller.equipments.isEmpty ? 
                  const CircularProgressIndicator(
                    color: Color(0xFFFF5454),
                  
                  ) : 
                  RefreshIndicator(
                    onRefresh: () => controller.getEquipments(),
                    child: ListView.builder(
                      itemCount: controller.equipments.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                          child: GestureDetector(
                            onTap: (){
                              Get.to(() => const EquipmentScreen(), transition: Transition.fadeIn, arguments: controller.equipments[index].id);
                            },
                            child: EquipmentCard(
                              name: controller.equipments[index].name, 
                              category: controller.equipments[index].category, 
                              stock: controller.equipments[index].stock.toInt(),
                              imageUrl: controller.equipments[index].imageUrl!,
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}