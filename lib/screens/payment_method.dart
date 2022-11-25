
import 'package:flutter/material.dart';
import 'package:phileaflorist/screens/pay_by_card.dart';

import '../utils/app_constants.dart';
import '../widgets/Text_widget.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.subTxtColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 21,
                    ),
                    TextWidget(
                      txt: "Kategori",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              const Divider(
                thickness: 1,
                height: 0,
                color: AppConstants.txtFieldColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayByCard()));
                      },
                      splashColor: AppConstants.txtFieldColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 19),
                        child: Row(
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: AppConstants.primaryColor,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 19,
                            ),
                            TextWidget(
                                txt: "kartu kredit",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                textColor: AppConstants.titleTextColor),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayByCard()));
                      },
                      splashColor: AppConstants.txtFieldColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 19),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/paypal.png",
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 19,
                            ),
                            TextWidget(
                                txt: "Dana",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                textColor: AppConstants.titleTextColor),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: AppConstants.txtFieldColor.withOpacity(0.5),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayByCard()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 19),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance,
                              color: AppConstants.primaryColor,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 19,
                            ),
                            TextWidget(
                                txt: "Bank Transfer",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                textColor: AppConstants.titleTextColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
