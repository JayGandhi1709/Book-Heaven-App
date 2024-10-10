import 'package:book_heaven/models/address.dart';
import 'package:book_heaven/screens/user/address/add_address_screen.dart';
import 'package:book_heaven/screens/user/address/address_controller.dart';
import 'package:book_heaven/screens/user/checkout/checkout_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({super.key, this.selectable = false});

  final bool selectable;

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  AddressModel? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectable ? 'Select Address' : "Manage Address"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Show dialog to add new address
              showDialog(
                context: context,
                builder: (context) => AddressDialog(
                  onSave: (address) {
                    context.addressController.addAddress(address);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AddressController>(
          init: AddressController(context.userController.user.id!),
          // init: controller,
          builder: (controller) {
            // make custom Card for each address
            return Column(
              children: controller.allAddress
                  .map(
                    (address) => Card(
                      child: ListTile(
                        leading: widget.selectable
                            ? widget.selectable
                                ? Radio(
                                    value: address,
                                    groupValue: selectedAddress,
                                    onChanged: (value) {
                                      selectedAddress = value;
                                      setState(() {});
                                    },
                                  )
                                : null
                            : null,
                        title: Text(address.street),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${address.city}, ${address.state} - ${address.zipCode}'),
                            Text("Contact: ${address.contactNumber}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                              ),
                              onPressed: () {
                                // Show dialog to edit address
                                showDialog(
                                  context: context,
                                  builder: (context) => AddressDialog(
                                    address: address,
                                    onSave: (address) {
                                      controller.updateAddress(address);
                                    },
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                              ),
                              onPressed: () {
                                controller.deleteAddress(address.id!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
      bottomNavigationBar: widget.selectable
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedAddress != null) {
                    // Set the selected address
                    // context.addressController.selectAddress(selectedAddress!);
                    Get.to(() =>
                        CheckoutScreen(selectedAddress: selectedAddress!));
                  } else {
                    showSnackBar("Please select an address", MsgType.error);
                  }
                },
                child: const Text('Select Address'),
              ),
            )
          : null,
    );
  }
}
