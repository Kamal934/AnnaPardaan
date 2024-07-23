import 'package:flutter/material.dart';
import 'package:annapardaan/screens/Insights/insigths_card.dart';

import '../../utils/constants/images.dart';
import '../../utils/constants/text_strings.dart';

class Insights extends StatelessWidget {
  final String subtitle;
  final bool isDonorScreen;

  const Insights({
    super.key,
    required this.subtitle,
    required this.isDonorScreen,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 15),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset(TImages.trophyImageIcon),
                ),
              ),
              const Text(
                TText.insight,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  InsightCard(
                    count:'4',
                    label:  isDonorScreen ? TText.totalDonation :TText.taskCompleted,
                  ),
                  const InsightCard(count: '57', label: TText.overallStreaks),
                ],
              ),
              const Row(
                children: [
                  InsightCard(count: '3rd', label: TText.rankInWorkforce),
                  InsightCard(count: '2.7k', label:TText.pointEarned),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
