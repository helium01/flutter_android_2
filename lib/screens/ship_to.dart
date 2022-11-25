
import 'package:flutter/material.dart';
import 'package:phileaflorist/screens/payment_method.dart';
import 'package:phileaflorist/widgets/shipping_detail_container.dart';

import '../utils/app_constants.dart';
import '../widgets/Text_widget.dart';
import '../widgets/button_widget.dart';

class ShipTo extends StatelessWidget {
  const ShipTo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.subTxtColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 21,
                    ),
                    Expanded(
                        child: TextWidget(
                      txt: "kirim ke",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    )),
                    Icon(
                      Icons.add,
                      color: AppConstants.primaryColor,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                const Divider(
                  thickness: 1,
                  height: 0,
                  color: AppConstants.txtFieldColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                ShippingDetailContainer(
                  userName: "Fajar",
                  phoneNumber: '081937872369',
                  address:
                      'jl dahlia rt 30 rw 09 sukoanyar wajak | 65173',
                ),
                const SizedBox(
                  height: 16,
                ),
                
                const SizedBox(
                  height: 61,
                ),
                ButtonWidget(buttonText: 'Next', onPressed: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentMethod())); },),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
