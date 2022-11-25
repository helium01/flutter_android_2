import 'package:flutter/material.dart';

import '../utils/app_constants.dart';
import 'Text_widget.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/coba1.png",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  txt: "Philea florist bali",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  textColor: AppConstants.whiteColor,
                ),
                const SizedBox(
                  height: 18,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
