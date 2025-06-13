// // tracking_view.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'tracking_cubit.dart';
// import 'tracking_state.dart';

// class TrackingView extends StatelessWidget {
//   const TrackingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => TrackingCubit()..updateDeliveryProgress(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Column(
//             children: [
//               // Custom App Bar
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.black,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const Spacer(),
//                     // Location/Target icon
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Icon(
//                         Icons.my_location,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Map Section
//               Expanded(
//                 flex: 3,
//                 child: Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Stack(
//                     children: [
//                       // Map placeholder with route
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: CustomPaint(
//                           size: Size.infinite,
//                           painter: RoutePainter(),
//                         ),
//                       ),
//                       // Delivery person marker
//                       const Positioned(
//                         bottom: 40,
//                         right: 30,
//                         child: Icon(
//                           Icons.delivery_dining,
//                           color: Colors.orange,
//                           size: 32,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Bottom Section
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(24),
//                       topRight: Radius.circular(24),
//                     ),
//                   ),
//                   child: BlocBuilder<TrackingCubit, TrackingState>(
//                     builder: (context, state) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Status Badge
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 6,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: const Text(
//                               "Albotheify",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 16),

//                           // Time and Address
//                           Text(
//                             state.isDelivered
//                                 ? "Delivered"
//                                 : "${state.timeLeftMinutes} minutes left",
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           const Text(
//                             "Delivery to Jl. Kpg Sutoyo",
//                             style: TextStyle(fontSize: 14, color: Colors.grey),
//                           ),

//                           const SizedBox(height: 20),

//                           // Progress Indicators
//                           Row(
//                             children: [
//                               _buildProgressDot(true),
//                               const SizedBox(width: 8),
//                               _buildProgressDot(true),
//                               const SizedBox(width: 8),
//                               _buildProgressDot(true),
//                               const SizedBox(width: 8),
//                               _buildProgressDot(false),
//                             ],
//                           ),

//                           const SizedBox(height: 24),

//                           // Delivery Status Card
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade50,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: Colors.grey.shade200),
//                             ),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.orange.shade100,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Icon(
//                                     Icons.local_shipping,
//                                     color: Colors.orange.shade700,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Delivered your order",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       Text(
//                                         "We will deliver your goods to you in the shortest possible time.",
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // Delivery Person Info
//                           Row(
//                             children: [
//                               const CircleAvatar(
//                                 radius: 24,
//                                 backgroundImage: NetworkImage(
//                                   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               const Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Brooklyn Simmons",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Personal Courier",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   color: Colors.green.shade50,
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Icon(
//                                   Icons.call,
//                                   color: Colors.green.shade700,
//                                   size: 20,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressDot(bool isActive) {
//     return Container(
//       width: 8,
//       height: 8,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.green : Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }
// }

// // Custom painter for the route line on map
// class RoutePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.orange
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;

//     final path = Path();

//     // Draw a simple route path
//     path.moveTo(size.width * 0.1, size.height * 0.2);
//     path.lineTo(size.width * 0.3, size.height * 0.15);
//     path.lineTo(size.width * 0.6, size.height * 0.1);
//     path.lineTo(size.width * 0.8, size.height * 0.2);
//     path.lineTo(size.width * 0.85, size.height * 0.4);

//     canvas.drawPath(path, paint);

//     // Draw start point
//     canvas.drawCircle(
//       Offset(size.width * 0.1, size.height * 0.2),
//       6,
//       Paint()..color = Colors.green,
//     );

//     // Draw end point
//     canvas.drawCircle(
//       Offset(size.width * 0.85, size.height * 0.4),
//       6,
//       Paint()..color = Colors.red,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
