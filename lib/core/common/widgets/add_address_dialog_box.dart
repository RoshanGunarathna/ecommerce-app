// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_app/features/address/controller/address_controller.dart';
import 'package:ecommerce_app/model/address_model.dart';

import '../custom_text_field.dart';
import '../../palette.dart';

class AddEditDialog extends ConsumerStatefulWidget {
  final AddressModel? address;
  final int? index;
  const AddEditDialog({
    this.address,
    this.index,
  });

  @override
  ConsumerState<AddEditDialog> createState() => _AddEditDialogConsumerState();
}

class _AddEditDialogConsumerState extends ConsumerState<AddEditDialog> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityTownController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  final _addressFormKey = GlobalKey<FormState>();

  //for the default address part
  bool? isDefaultAddress = false;

  void init() {
    if (widget.address != null) {
      _fullNameController.text = widget.address!.fullName;
      _addressController.text = widget.address!.address;
      _cityTownController.text = widget.address!.cityTown;
      _mobileNumberController.text = widget.address!.mobileNumber;
      _provinceController.text = widget.address!.province;
      _zipCodeController.text = widget.address!.zipCode;
    }
    if (widget.index != null) {
      if (widget.index == 0) {
        isDefaultAddress = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _mobileNumberController.dispose();
    _provinceController.dispose();
    _cityTownController.dispose();
    _zipCodeController.dispose();
  }

  void navigateToBack() {
    Navigator.pop(context);
  }

  void saveAddress() {
    final bool isOk = _addressFormKey.currentState!.validate();
    if (isOk) {
      ref.read(addressControllerProvider.notifier).addUpdateAddress(
            address: _addressController.text,
            cityTown: _cityTownController.text,
            fullName: _fullNameController.text,
            mobileNumber: _mobileNumberController.text,
            province: _provinceController.text,
            isDefaultAddress: isDefaultAddress!,
            zipCode: _zipCodeController.text,
            context: context,
            dateTime: widget.address != null ? widget.address!.dateTime : null,
            id: widget.address != null ? widget.address!.id : null,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        insetPadding: const EdgeInsets.all(0),
        content: ConstrainedBox(
          constraints: const BoxConstraints.expand(
            height: 500,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Default"),
                          Checkbox(
                              activeColor: primaryColor,
                              value: isDefaultAddress,
                              onChanged: (value) {
                                setState(() {
                                  isDefaultAddress = value;
                                });
                              }),
                        ],
                      ),
                      Form(
                        key: _addressFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _fullNameController,
                              hintText: 'Full Name',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _mobileNumberController,
                              hintText: 'Mobile Number',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _addressController,
                              hintText: 'Address',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _provinceController,
                              hintText: 'Province',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _cityTownController,
                              hintText: 'Town/City',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _zipCodeController,
                              hintText: 'Zip Code/Postal Code',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text(
                              "Go Back",
                              style: TextStyle(fontSize: 20, color: blackColor),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            onPressed: saveAddress,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
