import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/order/order_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../../models/order_model.dart';
import '../../models/address_model.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';

class OrderFormScreen extends StatefulWidget {
  const OrderFormScreen({super.key});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  // Register controllers before using .to
  static void _ensureControllersRegistered() {
    if (!Get.isRegistered<ProductController>()) {
      Get.put(ProductController());
    }
    if (!Get.isRegistered<OrderController>()) {
      Get.put(OrderController());
    }
  }

  // This runs before any instance fields are initialized
  _OrderFormScreenState() {
    _ensureControllersRegistered();
  }

  late final ProductController _productController = ProductController.to;

  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _addressNameController = TextEditingController();
  final _addressPhoneController = TextEditingController();
  final _addressStreetController = TextEditingController();
  final _addressWardController = TextEditingController();
  final _addressDistrictController = TextEditingController();
  final _addressProvinceController = TextEditingController();

  bool _isSubmitting = false;
  final Map<String, int> _selectedProducts = {}; // productId -> quantity

  @override
  void initState() {
    super.initState();
    _productController.fetchData();
  }

  @override
  void dispose() {
    _userIdController.dispose();
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

    // Build CartItemModel list from selected products
    final items = _selectedProducts.entries.map((entry) {
      final product = _productController.allItems.firstWhere((p) => p.id == entry.key);
      return CartItemModel(
        productId: product.id,
        title: product.title,
        price: product.price,
        quantity: entry.value,
        image: product.thumbnail,
      );
    }).toList();

    final totalAmount = items.fold<double>(0, (sum, item) => sum + item.price * item.quantity);

    final order = OrderModel(
      id: '',
      userId: _userIdController.text,
      status: OrderStatus.pending,
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
              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(labelText: 'User ID'),
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
                    return Row(
                      children: [
                        Checkbox(
                          value: _selectedProducts.containsKey(product.id),
                          onChanged: (selected) {
                            setState(() {
                              if (selected == true) {
                                _selectedProducts[product.id] = 1;
                              } else {
                                _selectedProducts.remove(product.id);
                              }
                            });
                          },
                        ),
                        Expanded(child: Text(product.title)),
                        if (_selectedProducts.containsKey(product.id))
                          SizedBox(
                            width: 60,
                            child: TextFormField(
                              initialValue: _selectedProducts[product.id].toString(),
                              decoration: const InputDecoration(labelText: 'Qty'),
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                final qty = int.tryParse(val) ?? 1;
                                setState(() {
                                  _selectedProducts[product.id] = qty;
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
                      ],
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 16),
              const Text('Payment', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _paymentMethodController,
                decoration: const InputDecoration(labelText: 'Payment Method'),
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