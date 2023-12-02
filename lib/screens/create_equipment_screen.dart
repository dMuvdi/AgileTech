import 'package:agile_tech/controllers/create_equipment_controller.dart';
import 'package:agile_tech/widgets/custom_dropdown.dart';
import 'package:agile_tech/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEquipmentScreen extends StatelessWidget {
  const CreateEquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CreateEquipmentController());

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFFF5454),
        title: const Text('Añadir Equipo', 
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Form(
                key: controller.formKey,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return GetBuilder<CreateEquipmentController>(
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Detalles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF670F0F)),),
                            const SizedBox(height: 20,),
                            CustomTextField(
                              hintText: 'Nombre', 
                              type: TextInputType.name, 
                              validator: (value) => controller.validateName(value!),
                              isPassword: false,
                              borderColor: const Color(0xFF670F0F),
                              fillColor: Colors.white,
                              onChanged: (value) => controller.setName = value,
                            ),
                            const SizedBox(height: 10,),
                            CustomTextField(
                              hintText: 'Descripción', 
                              type: TextInputType.name, 
                              isPassword: false,
                              validator: (value) => controller.validateStockAndDescription(value!),
                              borderColor: const Color(0xFF670F0F),
                              fillColor: Colors.white,
                              onChanged: (value) => controller.setDescription = value,
                              maxLines: false,
                            ),
                            const SizedBox(height: 10,),
                            CustomTextField(
                              hintText: 'Stock', 
                              type: TextInputType.number, 
                              isPassword: false,
                              validator: (value) => controller.validateStockAndDescription(value!),
                              borderColor: const Color(0xFF670F0F),
                              fillColor: Colors.white,
                              onChanged: (value) => controller.setStock = value,
                            ),
                            const SizedBox(height: 10,),
                            Obx(() {
                              return CustomDropDown(
                                hintText: 'Categoría',
                                items: controller.dropdownItems,
                                onChanged: (value) => controller.updateDropdownItem(value!),
                                value: controller.currentCategory.value,
                                fillColor: Colors.white,
                                borderColor: const Color(0xFF670F0F),
                              );
                            }),
                            const SizedBox(height: 40,),
                            const Text('Opcional', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF670F0F),),),
                            const SizedBox(height: 10,),
                            controller.imageFile != null ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                controller.imageFile!,
                                width: double.infinity,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ) :
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  image: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg'),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            const SizedBox(height: 10,),
                            TextButton(
                              onPressed: () async {
                                controller.pickImage();
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.white),
                                backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE1E1)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                              ), 
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate_outlined, color: Color(0xFF670F0F),),
                                  SizedBox(width: 5,),
                                  Text('Añadir imagen', style: TextStyle(color: Color(0xFF670F0F), fontFamily: 'Montserrat', fontWeight: FontWeight.w700, fontSize: 14),),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            TextButton(
                              onPressed: () async {
                                
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.white),
                                backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE1E1)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
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
                            const SizedBox(height: 130,),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: GetBuilder<CreateEquipmentController>(
                                  id: 'loading',
                                  builder: (context) {
                                    return TextButton(
                                      onPressed: () async {
                                        await controller.onSubmit();
                                      },
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(const Color(0xFF670F0F)),
                                        backgroundColor: MaterialStateProperty.all(const Color(0xFFFF5454)),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                                        fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                                      ), 
                                      child: controller.loading == false ? const Text(
                                        'Añadir',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ):
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          backgroundColor: Color(0xFF670F0F),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    );
                  }
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: 15,
              decoration: const BoxDecoration(
                color: Color(0xFFFF5454),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}