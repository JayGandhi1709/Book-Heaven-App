import 'package:book_heaven/common/custom_pdf_view.dart';
import 'package:book_heaven/screens/user/order/order_controller.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EBooksScreen extends StatelessWidget {
  const EBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Books"),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<OrderController>(
          init: OrderController(context.userController.user),
          builder: (controller) {
            // make custom Card for each address
            if (controller.allEBooksOrders.isEmpty) {
              return const Center(
                child: Text("No purchased Ebooks Found"),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: controller.allEBooksOrders
                    .expand(
                      (order) => order.orderItems.map(
                        (orderItem) => Card(
                          child: ListTile(
                            leading: SizedBox(
                              height: 250,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            orderItem.book.img.first),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(orderItem.book.title),
                            onTap: () => Get.to(() => CustomPdfViewer(
                                  pdfUrl: orderItem.book.pdfUrl!,
                                  isPurchased: true,
                                )),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
