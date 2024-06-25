import 'package:animated_button_progress/homepage.dart';
import 'package:flutter/material.dart';
import 'package:gusto_neumorphic/gusto_neumorphic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Button Progress',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   late Animation<double> _animation;
//   late AnimationController _animationController;
//   bool isPaused = true;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 4000),
//       vsync: this,
//     )..addListener(() {});
//     _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white70,
//       appBar: AppBar(
//         title: const Text('Animated Button Progress'),
//       ),
//       body: AnimatedBuilder(
//           animation: _animationController,
//           builder: (context, child) {
//             return Neumorphic(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       //inner circle with convex shape
//                       Neumorphic(
//                         style: NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.circle(),
//                           disableDepth: true,
//                           intensity: 10,
//                           shape: NeumorphicShape.convex,
//                           lightSource: LightSource.topRight,
//                         ),
//                         child: Container(
//                           width: context.sizeWidth(0.48),
//                           height: context.sizeHeight(0.22),
//                           margin: EdgeInsets.all(10),
//                         ),
//                       ),
//                       Neumorphic(
//                         style: NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.circle(),
//                           disableDepth: true,
//                           intensity: 10,
//                           shape: NeumorphicShape.flat,
//                           depth: -10,
//                           surfaceIntensity: 0,
//                           lightSource: LightSource.bottomLeft,
//                         ),
//                         child: SizedBox(
//                           width: context.sizeWidth(0.5),
//                           height: context.sizeHeight(0.23),
//                           child: CircularProgressIndicator(
//                             value: _animation.value,
//                             strokeWidth: 26,
//                             color: AppColors.yellow100,
//                             backgroundColor: AppColors.greyRing200,
//                             strokeCap: StrokeCap.round,
//                           ),
//                         ),
//                       ),

//                       //inner circle with button icon
//                       Neumorphic(
//                         style: const NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.circle(),
//                           shape: NeumorphicShape.convex,
//                           depth: -3,
//                         ),
//                         drawSurfaceAboveChild: false,
//                         child: Container(
//                           width: context.sizeWidth(0.3),
//                           height: context.sizeHeight(0.11),
//                           margin: EdgeInsets.all(3),

//                           // decoration: BoxDecoration(
//                           //     shape: BoxShape.circle,
//                           //     color: Colors.grey[200],
//                           //     gradient: const RadialGradient(
//                           //       center: Alignment.topLeft,
//                           //       radius: 1.5,
//                           //       tileMode: TileMode.mirror,
//                           //       colors: [
//                           //         AppColors.greyCenter200,
//                           //         AppColors.greyCenter100,
//                           //       ],
//                           //     )),
//                           child: IconButton(
//                             onPressed: () {
//                               if (_animation.isCompleted) {
//                                 _animationController.reset();
//                                 isPaused = true;
//                               } else if (_animationController.isAnimating) {
//                                 _animationController.stop();
//                                 isPaused = true;
//                               } else {
//                                 _animationController.forward();
//                                 isPaused = false;
//                               }
//                               setState(() {});
//                             },
//                             icon: Icon(
//                               _animation.isCompleted
//                                   ? Icons.recycling
//                                   : isPaused
//                                       ? Icons.play_arrow
//                                       : Icons.pause,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     '${(_animation.value * 100).round()}% downloading..',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }

