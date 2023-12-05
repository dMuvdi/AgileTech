import 'package:agile_tech/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_report_controller.dart';

class CreateReportScreen extends StatelessWidget {
  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CreateReportController());

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFFF5454),
        title: const Text('Añadir Reporte', 
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
            controller.equipmentId = null;
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
                    return GetBuilder<CreateReportController>(
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Detalles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF670F0F)),),
                            const SizedBox(height: 20,),
                            CustomTextField(
                              hintText: 'Código', 
                              type: TextInputType.name, 
                              validator: (value) => controller.validateCode(value!),
                              isPassword: false,
                              borderColor: const Color(0xFF670F0F),
                              fillColor: Colors.white,
                              onChanged: (value) => controller.setCode = value,
                            ),
                            const SizedBox(height: 10,),
                            CustomTextField(
                              hintText: 'Descripción', 
                              type: TextInputType.name, 
                              isPassword: false,
                              validator: (value) => controller.validateDescription(value!),
                              borderColor: const Color(0xFF670F0F),
                              fillColor: Colors.white,
                              onChanged: (value) => controller.setDescription = value,
                              maxLines: false,
                            ),
                            SizedBox(height: Get.height / 2,),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: GetBuilder<CreateReportController>(
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