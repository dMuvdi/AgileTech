import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class EquipmentCard extends StatelessWidget {
  const EquipmentCard({
    super.key,
    required this.name,
    required this.category,
    required this.stock,
    required this.imageUrl
  });

  final String name;
  final String category;
  final int stock;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 7,
            offset: const Offset(0, 0), // changes the position of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover
                )
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontFamily: FontFamilyToken.montserrat,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      category,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: FontFamilyToken.montserrat,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 35,
                      child: Text(
                        '$stock',
                        style: const TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontFamily: FontFamilyToken.montserrat,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      child: Text(
                        'Stock',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: FontFamilyToken.montserrat,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ]
        ),
      ),
    );
  }
}