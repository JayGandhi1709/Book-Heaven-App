import 'package:book_heaven/models/address.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressDialog extends StatelessWidget {
  final AddressModel?
      address; // Use null for new address, or pass existing address for editing
  final Function(AddressModel) onSave;

  const AddressDialog({super.key, this.address, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    final TextEditingController streetController =
        TextEditingController(text: address?.street ?? '');
    final TextEditingController cityController =
        TextEditingController(text: address?.city ?? '');
    final TextEditingController stateController =
        TextEditingController(text: address?.state ?? '');
    final TextEditingController zipCodeController =
        TextEditingController(text: address?.zipCode ?? '');
    final TextEditingController contactNumberController =
        TextEditingController(text: address?.contactNumber ?? '');

    return AlertDialog(
      title: Text(address == null ? 'Add New Address' : 'Edit Address'),
      content: SizedBox(
        width: Get.width * 0.8,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: streetController,
                  decoration: const InputDecoration(labelText: 'Street'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(labelText: 'State'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: zipCodeController,
                  decoration: const InputDecoration(labelText: 'Zip Code'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: contactNumberController,
                  decoration: const InputDecoration(
                      labelText: 'Contact Number',
                      prefix: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('+91'),
                      )),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (!_formkey.currentState!.validate()) return;
            final newAddress = AddressModel(
              id: address?.id,
              userId: address?.userId ?? context.userController.user.id!,
              street: streetController.text,
              city: cityController.text,
              state: stateController.text,
              zipCode: zipCodeController.text,
              contactNumber: contactNumberController.text,
            );
            onSave(newAddress);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
