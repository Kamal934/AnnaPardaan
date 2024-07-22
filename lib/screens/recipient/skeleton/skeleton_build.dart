
import 'package:flutter/material.dart';

class BuildSkeletonDonationDetails extends StatelessWidget {
  const BuildSkeletonDonationDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SkeletonContainer.square(
                      width: 70,
                      height: 70,
                    ),
                    SizedBox(
                      width: 10,
                      height: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonContainer.rounded(
                          width: 100,
                          height: 20,
                        ),
                        SizedBox(height: 5),
                        SkeletonContainer.rounded(
                          width: 60,
                          height: 15,
                        ),
                        SizedBox(height: 5),
                        SkeletonContainer.rounded(
                          width: 150,
                          height: 15,
                        ),
                        SizedBox(height: 5),
                        SkeletonContainer.rounded(
                          width: 100,
                          height: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Photos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(
              3,
              (index) => const SkeletonContainer.square(
                  width: 70, height: 70,),),
                
        ),
        const SizedBox(height: 16),
        const Text(
          'Diet Type',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              3,
              (index) =>
                  const SkeletonContainer.rounded(width: 100, height: 40)),
        ),
        const SizedBox(height: 16),
        const Text(
          'Meal Quantity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const SkeletonContainer.rounded(width: double.infinity, height: 20),
        const SizedBox(height: 16),
        const Text(
          'Instructions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const SkeletonContainer.rounded(width: double.infinity, height: 60),
        const SizedBox(height: 16),
        const Text(
          'Locations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const SkeletonContainer.rounded(width: double.infinity, height: 60),
        const SizedBox(height: 16),
        const Row(
          children: [
            SkeletonContainer.rounded(width: 20, height: 20),
            SizedBox(width: 8),
            SkeletonContainer.rounded(width: 100, height: 20),
          ],
        ),
        const Row(
          children: [
            SkeletonContainer.rounded(width: 20, height: 20),
            SizedBox(width: 8),
            SkeletonContainer.rounded(width: 160, height: 20),
          ],
        ),
        const SizedBox(height: 16),
        const SkeletonContainer.rounded(width: double.infinity, height: 20),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkeletonContainer.rounded(width: 160, height: 50),
            SkeletonContainer.rounded(width: 160, height: 50),
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonContainer.square({
    super.key,
    required this.width,
    required this.height,
  })  : borderRadius = null;

  const SkeletonContainer.rounded({
    super.key,
    required this.width,
    required this.height,
  })  : borderRadius = const BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
      ),
    );
  }
}
