import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class ARPage extends StatefulWidget {
  const ARPage({Key? key}) : super(key: key);

  @override
  _ARPageState createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  late ARKitController arkitController;

  // List of planets and solar system overview
  final List<Map<String, dynamic>> planets = [
    {
      "name": "Solar System",
      "modelUri": "assets/models/solar_system_animation.usdz",
      "description": "Our solar system includes the Sun, eight planets, and many moons."
    },
    {"name": "Sun", "modelUri": "assets/models/sun.usdz", "description": "The Sun is the center of our solar system."},
    {"name": "Mercury", "modelUri": "assets/models/mercury.usdz", "description": "Mercury is the closest planet to the Sun."},
    {"name": "Venus", "modelUri": "assets/models/venus.usdz", "description": "Venus is similar in size to Earth."},
    {"name": "Earth", "modelUri": "assets/models/earth.usdz", "description": "Earth is the only planet known to harbor life."},
  ];

  int currentPlanetIndex = 0;
  final List<String> addedNodeNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Planets Viewer'),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Stack(
        children: [
          ARKitSceneView(
            onARKitViewCreated: onARKitViewCreated,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black54,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Viewing: ${planets[currentPlanetIndex]['name']}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    planets[currentPlanetIndex]['description'],
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _previousPlanet,
                        child: const Text("Previous"),
                      ),
                      ElevatedButton(
                        onPressed: _nextPlanet,
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onARKitViewCreated(ARKitController controller) {
    arkitController = controller;
    _loadCurrentPlanet();
  }

  void _loadCurrentPlanet() {
    // Remove all existing nodes
    for (final nodeName in addedNodeNames) {
      arkitController.remove(nodeName); // Remove each node by name
    }
    addedNodeNames.clear();

    // Add the new planet or solar system model
    final planetNode = ARKitReferenceNode(
      url: planets[currentPlanetIndex]['modelUri']!,
      position: vm.Vector3(0.0, 0.0, -1.5), // Place 1.5 meters in front
      scale: vm.Vector3(0.05, 0.05, 0.05), // Scale the model appropriately
    );

    arkitController.add(planetNode);

    addedNodeNames.add(planetNode.name); // Track the node name for future removal
  }

  void _previousPlanet() {
    setState(() {
      currentPlanetIndex = (currentPlanetIndex - 1 + planets.length) % planets.length;
    });
    _loadCurrentPlanet();
  }

  void _nextPlanet() {
    setState(() {
      currentPlanetIndex = (currentPlanetIndex + 1) % planets.length;
    });
    _loadCurrentPlanet();
  }

  @override
  void dispose() {
    arkitController.dispose(); // Dispose ARKit controller
    super.dispose();
  }
}



// import 'package:flutter/material.dart';
//
// class ARPage extends StatelessWidget {
//   const ARPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'AR Page',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:vector_math/vector_math_64.dart' as vm;

// class ARPage extends StatefulWidget {
//   const ARPage({super.key});

//   @override
//   _ARPageState createState() => _ARPageState();
// }

// class _ARPageState extends State<ARPage> {
//   late ArCoreController arCoreController;

//   // List of planets and solar system overview
//   final List<Map<String, dynamic>> planets = [
//     {
//       "name": "Solar System",
//       "modelUri": "assets/models/solar_system_animation.glb",
//       "description": "Our solar system includes the Sun, eight planets, five officially named dwarf planets, and hundreds of moons."
//     },
//     {"name": "Sun", "modelUri": "assets/models/sun.glb", "description": "The Sun is the center of our solar system and a massive source of energy."},
//     {"name": "Mercury", "modelUri": "assets/models/mercury.glb", "description": "Mercury is the smallest planet in our solar system and closest to the Sun."},
//     {"name": "Venus", "modelUri": "assets/models/venus.glb", "description": "Venus is known as Earth's twin due to its similar size and composition."},
//     {"name": "Earth", "modelUri": "assets/models/earth.glb", "description": "Earth is the only planet known to harbor life."},
//     {"name": "Mars", "modelUri": "assets/models/mars.glb", "description": "Mars is known as the Red Planet due to its reddish appearance."},
//     {"name": "Jupiter", "modelUri": "assets/models/jupiter.glb", "description": "Jupiter is the largest planet in the solar system."},
//     {"name": "Saturn", "modelUri": "assets/models/saturn.glb", "description": "Saturn is famous for its prominent ring system."},
//     {"name": "Uranus", "modelUri": "assets/models/uranus.glb", "description": "Uranus rotates on its side and has a pale blue color."},
//     {"name": "Neptune", "modelUri": "assets/models/neptune.glb", "description": "Neptune is a deep blue planet and the farthest from the Sun."}
//   ];

//   int currentPlanetIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AR Planets Viewer'),
//         automaticallyImplyLeading: false, // Removes the back button
//       ),
//       body: Stack(
//         children: [
//           ArCoreView(
//             onArCoreViewCreated: onArCoreViewCreated,
//           ),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               color: Colors.black54,
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "Viewing: ${planets[currentPlanetIndex]['name']}",
//                     style: const TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     planets[currentPlanetIndex]['description'],
//                     style: const TextStyle(color: Colors.white, fontSize: 14),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         onPressed: _previousPlanet,
//                         child: const Text("Previous"),
//                       ),
//                       ElevatedButton(
//                         onPressed: _nextPlanet,
//                         child: const Text("Next"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     _loadCurrentPlanet();
//   }

//   List<String> addedNodeNames = []; // Track the names of added nodes

//   void _loadCurrentPlanet() {
//     // Manually remove all existing nodes
//     for (final nodeName in addedNodeNames) {
//       arCoreController.removeNode(nodeName: nodeName); // Remove each node by name
//     }
//     addedNodeNames.clear(); // Clear the list after removing nodes

//     // Add the new planet or solar system model
//     final planetNode = ArCoreReferenceNode(
//       name: planets[currentPlanetIndex]['name']!,
//       object3DFileName: planets[currentPlanetIndex]['modelUri']!,
//       position: vm.Vector3(0.0, 0.0, -1.5), // Place 1.5 meters in front
//       scale: vm.Vector3(0.05, 0.05, 0.05), // Scale the model appropriately
//     );

//     arCoreController.addArCoreNodeWithAnchor(planetNode);

//     // Ensure the name is not null before adding it to the list
//     if (planetNode.name != null) {
//       addedNodeNames.add(planetNode.name!);
//     }
//   }

//   void _previousPlanet() {
//     setState(() {
//       currentPlanetIndex = (currentPlanetIndex - 1 + planets.length) % planets.length;
//     });
//     _loadCurrentPlanet();
//   }

//   void _nextPlanet() {
//     setState(() {
//       currentPlanetIndex = (currentPlanetIndex + 1) % planets.length;
//     });
//     _loadCurrentPlanet();
//   }

//   @override
//   void dispose() {
//     arCoreController.dispose(); // Dispose ArCore controller
//     super.dispose();
//   }
// }
