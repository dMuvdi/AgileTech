import 'package:agile_tech/screens/create_equipment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/equipment_controller.dart';

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
              ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    height: 300,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(controller.equipment!.imageUrl! == 'no image' ? 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg': controller.equipment!.imageUrl!),
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              ),
              // Page content
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Get.height / 1.5,
                  width: Get.width,
                  padding: const EdgeInsets.only(
                    top: 30,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  )
                ),
              ),
              // AppBar with elevation
              AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () { Get.back(); },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter, 
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const CreateEquipmentScreen(), transition: Transition.rightToLeftWithFade, duration: const Duration(milliseconds: 500));
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(const Color(0xFF670F0F)),
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFF5454)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                      fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                    ), 
                    child: const Text(
                      'Actualizar',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        ): Scaffold(backgroundColor: Colors.white, body: const Center(child: CircularProgressIndicator(color: Color(0xFFFF5454),)));
      }
    );
  }
}