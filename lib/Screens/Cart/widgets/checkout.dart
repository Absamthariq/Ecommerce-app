import 'package:ecommerce_app/model/cart_model/cart.dart';
import 'package:ecommerce_app/repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ChceckOut extends StatefulWidget {
  const ChceckOut({Key? key, required this.totalPrice}) : super(key: key);
  final double totalPrice;
  @override
  State<ChceckOut> createState() => _ChceckOutState();
}

// final List<Cart> cartItems = CartRepository.;
// final ValueNotifier<List<Cart>> cartItemsNotifier =
//     ValueNotifier<List<Cart>>(cartItems);

class _ChceckOutState extends State<ChceckOut> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: _startPayment(widget.totalPrice),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xFF139854),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 1),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Check Out',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  _startPayment(double totalPrice) {
    Razorpay razorpay = Razorpay();
    final options = {
      'key': 'rzp_test_qQ8v1TZlldglt9',
      'amount': totalPrice * 100, // amount in paise (e.g., 10000 = ₹100)
      'name': 'Test Payment',
      'description': 'Payment for products',
      'prefill': {
        'contact': 'CUSTOMER_PHONE_NUMBER',
        'email': 'CUSTOMER_EMAIL_ADDRESS',
      },
      'external': {
        'wallets': ['PAYTM', 'PHONEPE', 'GOOGLE_PAY'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print('Payment Success: Payment ID - ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print(
        'Payment Error: Code - ${response.code}, Message - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment
    print('External Wallet: Wallet Name - ${response.walletName}');
  }
}
