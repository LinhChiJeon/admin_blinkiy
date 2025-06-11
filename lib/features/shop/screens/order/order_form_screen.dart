import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/order/order_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../../models/order_model.dart';
import '../../models/address_model.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';

class OrderFormScreen extends StatefulWidget {
  const OrderFormScreen({super.key});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  static void _ensureControllersRegistered() {
    if (!Get.isRegistered<ProductController>()) {
      Get.put(ProductController());
    }
    if (!Get.isRegistered<OrderController>()) {
      Get.put(OrderController());
    }
  }

  _OrderFormScreenState() {
    _ensureControllersRegistered();
  }

  late final ProductController _productController = ProductController.to;

  final _formKey = GlobalKey<FormState>();
  final _paymentMethodController = TextEditingController();
  final _addressNameController = TextEditingController();
  final _addressPhoneController = TextEditingController();
  final _addressStreetController = TextEditingController();
  final _addressWardController = TextEditingController();
  final _addressDistrictController = TextEditingController();
  final _addressProvinceController = TextEditingController();

  bool _isSubmitting = false;
  // Map of productId to {quantity, size}
  final Map<String, Map<String, dynamic>> _selectedProducts = {};

  // User dropdown state
  List<UserModel> _users = [];
  String? _selectedUserId;

  @override
  void initState() {
    super.initState();
    _productController.fetchData();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('Users').get();
    final users = snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    setState(() {
      _users = users;
      if (_users.isNotEmpty) {
        _selectedUserId = _users.first.id;
      }
    });
  }

  @override
  void dispose() {
    _paymentMethodController.dispose();
    _addressNameController.dispose();
    _addressPhoneController.dispose();
    _addressStreetController.dispose();
    _addressWardController.dispose();
    _addressDistrictController.dispose();
    _addressProvinceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _selectedProducts.isEmpty) return;
    setState(() => _isSubmitting = true);

    final address = AddressModel(
      id: '',
      name: _addressNameController.text,
      phoneNumber: _addressPhoneController.text,
      street: _addressStreetController.text,
      ward: _addressWardController.text,
      district: _addressDistrictController.text,
      province: _addressProvinceController.text,
    );

    final items = _selectedProducts.entries.map((entry) {
      final product = _productController.allItems.firstWhere((p) => p.id == entry.key);
      final variation = product.productVariations!.firstWhere(
            (v) => v.size == entry.value['size'],
      );
      return CartItemModel(
        productId: product.id,
        title: product.title,
        price: variation.salePrice > 0 ? variation.salePrice : variation.price,
        quantity: entry.value['quantity'],
        image: product.thumbnail,
        size: entry.value['size'], // Include size in CartItemModel
      );
    }).toList();

    final totalAmount = items.fold<double>(0, (sum, item) => sum + item.price * item.quantity);

    final order = OrderModel(
      id: '',
      userId: _selectedUserId ?? '',
      status: OrderStatus.processing,
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      paymentMethod: _paymentMethodController.text,
      address: address,
      deliveryDate: null,
      items: items,
    );

    await OrderController.to.createOrder(order);

    setState(() => _isSubmitting = false);
    Get.snackbar('Success', 'Order created!');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Order')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('User Info', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedUserId,
                decoration: const InputDecoration(labelText: 'User'),
                items: _users
                    .map((user) => DropdownMenuItem(
                  value: user.id,
                  child: Text(user.fullName.isNotEmpty ? user.fullName : user.email),
                ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedUserId = val),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Products', style: TextStyle(fontWeight: FontWeight.bold)),
              Obx(() {
                if (_productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: _productController.allItems.map((product) {
                    final hasVariations = product.productVariations != null &&
                        product.productVariations!.isNotEmpty;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _selectedProducts.containsKey(product.id),
                              onChanged: (selected) {
                                setState(() {
                                  if (selected == true) {
                                    _selectedProducts[product.id] = {
                                      'quantity': 1,
                                      'size': hasVariations ? product.productVariations!.first.size : '',
                                    };
                                  } else {
                                    _selectedProducts.remove(product.id);
                                  }
                                });
                              },
                            ),
                            Expanded(child: Text(product.title)),
                          ],
                        ),
                        if (_selectedProducts.containsKey(product.id))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: _selectedProducts[product.id]!['quantity'].toString(),
                                    decoration: const InputDecoration(labelText: 'Qty'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (val) {
                                      final qty = int.tryParse(val) ?? 1;
                                      setState(() {
                                        _selectedProducts[product.id]!['quantity'] = qty;
                                      });
                                    },
                                    validator: (val) {
                                      if (_selectedProducts.containsKey(product.id) &&
                                          (int.tryParse(val ?? '') ?? 0) < 1) {
                                        return 'Min 1';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 16), // Add spacing between Qty and Size
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedProducts[product.id]!['size'],
                                    decoration: const InputDecoration(labelText: 'Size'),
                                    items: product.productVariations!
                                        .map((variation) => DropdownMenuItem(
                                      value: variation.size,
                                      child: Text(variation.size),
                                    ))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedProducts[product.id]!['size'] = val ?? '';
                                      });
                                    },
                                    validator: (v) => v == null || v.isEmpty ? 'Select a size' : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 16),
              const Text('Payment', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _paymentMethodController.text.isNotEmpty
                    ? _paymentMethodController.text
                    : null,
                decoration: const InputDecoration(labelText: 'Payment Method'),
                items: const [
                  DropdownMenuItem(
                    value: 'COD',
                    child: Text('Cash on Delivery (COD)'),
                  ),
                  DropdownMenuItem(
                    value: 'BankTransfer',
                    child: Text('Bank Transfer'),
                  ),
                ],
                onChanged: (val) {
                  setState(() {
                    _paymentMethodController.text = val ?? '';
                  });
                },
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _addressNameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: _addressPhoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: _addressStreetController,
                decoration: const InputDecoration(labelText: 'Street'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: _addressWardController,
                decoration: const InputDecoration(labelText: 'Ward'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: _addressDistrictController,
                decoration: const InputDecoration(labelText: 'District'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: _addressProvinceController,
                decoration: const InputDecoration(labelText: 'Province'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Create Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
