import 'package:ecommerce_app/Screens/Cart/widgets/checkout.dart';
import 'package:ecommerce_app/Screens/Cart/widgets/checkoutPage.dart';
import 'package:flutter/material.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({Key? key, required this.totalPrice})
      : super(key: key);
  final double totalPrice;
  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _addressLine1 = '';
  String _addressLine2 = '';
  String _city = '';
  String _state = '';
  String _postalCode = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform form submission logic here, such as saving the address details
      // or updating the user's address in the database

      // Display a success message or navigate to the next page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Address saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Delivery Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _fullName = value ?? '';
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Address Line 1'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addressLine1 = value ?? '';
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Address Line 2'),
                  onSaved: (value) {
                    _addressLine2 = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the city';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _city = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'State'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the state';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _state = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Postal Code'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the postal code';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _postalCode = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF139854),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      
                    ),
                  onPressed: () {
                    _submitForm();
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ChceckOut(totalPrice: widget.totalPrice,)),
                    );
                  },
                  child: const Text('Save and Pay',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
