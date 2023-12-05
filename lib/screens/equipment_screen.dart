import 'package:agile_tech/screens/create_equipment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/equipment_controller.dart';
import 'bottom_navigation.dart';
import 'create_report_screen.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(EquipmentController());

    return GetBuilder<EquipmentController>(
      builder: (context) {
        return controller.equipment != null ? Scaffold(
          body: Stack(
            children: [
              // Background image
              Positioned(
                top: 0,
                child: Container(
                  height: 300,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(controller.equipment!.imageUrl! == 'no image' ? 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg': controller.equipment!.imageUrl!),
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // AppBar with elevation
              AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () { 
                    controller.equipment = null;
                    Get.off(() => const BottomNavigation(), transition: Transition.leftToRight); 
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height / 1.5,
                      width: Get.width,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        children: [
                          Text(
                            controller.equipment!.name,
                            style: const TextStyle( 
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E1E),                 
                            ),
                          ),
                          Text(
                            controller.equipment!.category,
                            style: const TextStyle( 
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9A9A9A),            
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Color(0xFF9A9A9A),
                            thickness: 1,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Detalles de equipo',
                            style: TextStyle( 
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E1E),                 
                            ),
                          ),
                          Text(
                            controller.equipment!.description,
                            style: const TextStyle( 
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9A9A9A),            
                            )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Stock',
                                style: TextStyle( 
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),                 
                                ),
                              ),
                              Text(
                                '${controller.equipment!.stock}',
                                style: const TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF670F0F),
                                )
                              )
                            ],
                          ),
                          const Divider(
                            color: Color(0xFF9A9A9A),
                            thickness: 1,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Reportes',
                            style: TextStyle( 
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E1E),                 
                            ),
                          ),
                          controller.loading == true ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Color(0xFF670F0F),
                              backgroundColor: Colors.white,
                            ),
                          ): controller.reports.isEmpty ? const Text(
                            'No hay reportes',
                            style: TextStyle( 
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,                 
                            ),
                          ) : 
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              //physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.reports.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => const CreateReportScreen(), arguments: controller.reports[index], transition: Transition.rightToLeftWithFade, duration: const Duration(milliseconds: 500));
                                    controller.equipment = null;
                                  },
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Text('${controller.reports[index].code} - '),
                                        Text(DateFormat('MMM dd y').format(controller.reports[index].createdAt)),
                                      ],
                                    ),
                                    subtitle: Text(controller.reports[index].description),
                                    leading: const Icon(Icons.report_problem, color: Color(0xFF670F0F),),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const CreateReportScreen(), arguments: controller.equipment!.id, transition: Transition.rightToLeftWithFade, duration: const Duration(milliseconds: 500));
                              controller.equipment = null;
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE1E1)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                              fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                            ), 
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Color(0xFF670F0F),),
                                SizedBox(width: 5,),
                                Text('Añadir reporte', style: TextStyle(color: Color(0xFF670F0F), fontFamily: 'Montserrat', fontWeight: FontWeight.w700, fontSize: 14),),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const CreateEquipmentScreen(), transition: Transition.rightToLeftWithFade, duration: const Duration(milliseconds: 500), arguments: controller.equipment!);
                              controller.equipment = null;
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(const Color.fromARGB(255, 250, 181, 181)),
                              backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE1E1)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                              fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                            ), 
                            child: const Text(
                              'Actualizar',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF670F0F),
                              ),
                            )
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () async {
                              await controller.deleteEquipment();
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(const Color(0xFF670F0F)),
                              backgroundColor: MaterialStateProperty.all(const Color(0xFFFF5454)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                              fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                            ), 
                            child: controller.loading == false ? const Text(
                              'Eliminar',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ) : const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Color(0xFF670F0F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ): const Scaffold(backgroundColor: Colors.white, body: Center(child: CircularProgressIndicator(color: Color(0xFFFF5454),)));
      }
    );
  }
}