// import 'package:vector_math/vector_math_64.dart';
// import 'package:flutter/material.dart';

// class baselinetext extends statefulwidget {
//   final widget child;
//   baselinetext({this.child});

//   @override
//   _baselinetextstate createstate() => _baselinetextstate();
// }

// class _baselinetextstate extends state<baselinetext> {
//   globalkey _key = globalkey();

 
// }

// class BaseLineText extends StatefulWidget {
//   const BaseLineText({super.key});

//   @override
//   State<BaseLineText> createState() => _BaseLineTextState();
// }

// class _BaseLineTextState extends State<BaseLineText> {
//    void initstate() {
//     super.initstate();
//     widgetsbinding.instance.addpostframecallback((_) => setstate(() {}));
//   }

//   @override
//   widget build(buildcontext context) {
//     final renderbox renderbox = _key.currentcontext?.findrenderobject();
//     final height = renderbox?.size?.height ?? 0;
//     return baseline(
//       baseline: 0,
//       baselinetype: textbaseline.ideographic,
//       key: _key,
//       child: transform(
//         transform: matrix4.translation(
//           vector3(0, height, 0),
//         ),
//         child: widget.child,
//       ),
//     );
//   }
// }