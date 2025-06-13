import 'package:coffe_app/HomePage/home_view.dart';
import 'package:coffe_app/MapPage/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import 'package:latlong2/latlong.dart' as ll;

import '../../models/coffee_model.dart';
import '../TrackingPage/tracking_view.dart';
import 'order_cubit.dart';
import 'order_state.dart';

class OrderView extends StatelessWidget {
  final CoffeeModel coffee;

  const OrderView({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F9F9),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Order',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              final subtotal = coffee.price * state.quantity;
              final deliveryFee = state.isDelivery ? 2.0 : 0.0;
              final discount = 1.0;
              final total = subtotal + deliveryFee - discount;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildToggle(context, state),
                  const SizedBox(height: 20),
                  _buildBadge(),
                  const SizedBox(height: 16),
                  _buildAddressSection(context, state),
                  const SizedBox(height: 32),
                  _buildCoffeeItem(context, state),
                  const SizedBox(height: 24),
                  _buildDiscountCard(),
                  const SizedBox(height: 32),
                  _buildPaymentSummary(total, subtotal, deliveryFee),
                  const SizedBox(height: 32),
                  _buildOrderButton(context, state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildToggle(BuildContext context, OrderState state) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: ['Deliver', 'Pick Up'].map((label) {
          final isActive = (label == 'Deliver') == state.isDelivery;
          return Expanded(
            child: GestureDetector(
              onTap: () =>
                  context.read<OrderCubit>().toggleDelivery(label == 'Deliver'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFC67C4E)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        '327 ★ 43 Hug',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAddressSection(BuildContext context, OrderState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          state.selectedAddress ?? 'No address selected',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Tap Edit to choose location',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OpenStreetMapPicker(),
                  ),
                );

                if (result != null) {
                  final address = result['address'] as String;
                  final position = result['position'] as ll.LatLng;
                  context.read<OrderCubit>().updateAddress(address, position);
                }
              },
              child: _buildActionButton('Edit Address', Icons.edit),
            ),

            const SizedBox(width: 12),
            _buildActionButton('Add Note', Icons.note_add),
          ],
        ),
      ],
    );
  }

  Widget _buildCoffeeItem(BuildContext context, OrderState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(coffee.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Deep Foam',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _qtyButton(
                Icons.remove,
                () => context.read<OrderCubit>().decreaseQuantity(),
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  state.quantity.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _qtyButton(
                Icons.add,
                () => context.read<OrderCubit>().increaseQuantity(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, size: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildDiscountCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.local_offer, color: Color(0xFFC67C4E), size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '1 Discount is Applies',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(
    double total,
    double subtotal,
    double deliveryFee,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _summaryRow('Price', subtotal),
        const SizedBox(height: 12),
        _summaryRow('Delivery Fee', deliveryFee),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E5E5)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.account_balance_wallet,
                color: Color(0xFFC67C4E),
                size: 20,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Cash/Wallet',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '\$ ${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC67C4E),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _summaryRow(String title, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, color: Colors.black)),
        Text(
          '\$ ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildOrderButton(BuildContext context, OrderState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.isLoading
            ? null
            : () async {
                context.read<OrderCubit>().placeOrder();
                await Future.delayed(const Duration(seconds: 2));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Order Accepted'),
                    backgroundColor: Colors.green,
                  ),
                );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TrackingView()),
                // );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC67C4E),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: state.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Order',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
