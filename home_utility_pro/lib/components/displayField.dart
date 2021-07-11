// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:home_utility_pro/controllers/proController.dart';

// class DisplayField extends StatefulWidget {
//   final String text;
//   final IconData icon;
//   final Color textColour;
//   final double marginVertical;
//   final double marginHorizontal;
//   final Color iconColour;
//   final double iconSize;
//   final double borderRadius;
//   final Color boxColor;
//   final String displaytext;

//   const DisplayField({
//     this.text,
//     this.icon,
//     this.textColour,
//     this.marginVertical,
//     this.marginHorizontal,
//     this.iconColour,
//     this.iconSize,
//     this.borderRadius,
//     this.boxColor,
//     this.displaytext,
//   });

//   @override
//   _DisplayFieldState createState() => _DisplayFieldState();
// }

// class _DisplayFieldState extends State<DisplayField> {
//   final proController = Get.put(ProController());

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 10.0),
//             child: Icon(
//               widget.icon,
//               size: widget.iconSize,
//               color: widget.iconColour,
//             ),
//           ),
//           Flexible(
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 left: 16.0,
//               ),
//               child: Obx(
//                 () {
//                   if (proController.pro.isEmpty)
//                     return Text(
//                       widget.displaytext,
//                       style: GoogleFonts.montserrat(
//                           fontSize: 16,
//                           color: widget.textColour,
//                           fontWeight: FontWeight.bold),
//                     );
//                   return Text(widget.text,
//                       style: GoogleFonts.roboto(
//                         fontSize: 16,
//                         color: widget.textColour,
//                       ));
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       padding: EdgeInsets.all(12.0),
//       margin: EdgeInsets.symmetric(
//         vertical: widget.marginVertical,
//         horizontal: widget.marginVertical,
//       ),
//       height: size.height * 0.08,
//       width: size.width * 1.0,
//       decoration: BoxDecoration(
//         color: widget.boxColor,
//         borderRadius: BorderRadius.all(
//           Radius.circular(widget.borderRadius),
//         ),
//       ),
//     );
//   }
// }
