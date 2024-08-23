import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/app_color.dart';
import 'package:myapp/config/app_format.dart';
import 'package:myapp/controllers/booking_controller.dart';
import 'package:myapp/controllers/checkout_controller.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/widgets/header_worker_left.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final checkoutController = Get.put(CheckoutController());
  final bookingController = Get.put(BookingController());
  final userController = Get.put(UserController());

  @override
  void dispose() {
    checkoutController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 172,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.bgHeader,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderWorkerLeft(
                        title: 'Checkout',
                        subtitle: 'Star hiring and grow',
                        iconLeft: 'assets/ic_back.png',
                        functionLeft: () {
                          Navigator.pop(context);
                        },
                      ),
                      payments(),
                    ],
                  ),
                )
              ],
            ),
          ),
          Transform.translate(offset: const Offset(0, 60), child: walletBox()),
          DView.height(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Total Pay',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Obx(() {
                return Text(
                  AppFormat.price(bookingController.bookingDetail.grandTotal),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                );
              })
            ],
          ),
          DView.height(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Material(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                DView.width(8),
                const Text(
                  'I agree with the terms and conditions',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          DView.height(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              if (checkoutController.loading) return DView.loadingCircle();
              return FilledButton.icon(
                onPressed: () {
                  checkoutController.excute(
                      context, bookingController.bookingDetail);
                },
                icon: const ImageIcon(
                  AssetImage('assets/ic_secure.png'),
                ),
                label: const Text('Pay Now'),
              );
            }),
          ),
          DView.height(30),
          const Center(
            child: Text(
              'Read term and condition',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 16,
                color: Color(0xffb2b3bc),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget walletBox() {
    return Stack(children: [
      Image.asset(
        'assets/bg_card.png',
      ),
      Positioned(
        left: 60,
        top: 110,
        child: Text(
          AppFormat.price(49000),
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      Positioned(
        left: 60,
        bottom: 106,
        right: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return Text(
                userController.data.name ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              );
            }),
            const Text(
              '12/27',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget payments() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: checkoutController.payments.map((e) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    color: e['is_active']
                        ? Theme.of(context).primaryColor
                        : const Color(0xfff2f2f2),
                  ),
                  child: Image.asset(e['image']),
                ),
                DView.height(8),
                Text(
                  e['name'] ?? '',
                  style: TextStyle(
                    color:
                        e['is_active'] ? Colors.black : const Color(0xffa7a8b3),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
