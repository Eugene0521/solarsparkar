// arinteraction_page.dart
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:collection/collection.dart';
import '../models/planet.dart';

class ARInteractionPage extends StatefulWidget {
  final Planet planet;

  const ARInteractionPage({super.key, required this.planet});

  @override
  State<ARInteractionPage> createState() => _ARInteractionPageState();
}

class _ARInteractionPageState extends State<ARInteractionPage> {
  late ARKitController arkitController;
  ARKitNode? currentNode;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _startNarration(widget.planet.description); // Start narration on page load
  }

  Future<void> _startNarration(String text) async {
    if (!_isMuted) {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.0);
      await _flutterTts.speak(text);
    }
  }

  Future<void> _stopNarration() async {
    await _flutterTts.stop();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      if (_isMuted) {
        _stopNarration();
      } else {
        _startNarration(widget.planet.description);
      }
    });
  }

  @override
  void dispose() {
    _stopNarration();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Explore ${widget.planet.name}',
            style: const TextStyle(color: Colors.white), // White text for AppBar title
          ),
          backgroundColor: const Color(0xFF2B223E), // AppBar background color
          iconTheme: const IconThemeData(color: Colors.white), // White back icon
        ),
        body: Stack(
          children: [
            ARKitSceneView(
              showFeaturePoints: true,
              enableTapRecognizer: true,
              onARKitViewCreated: onARKitViewCreated,
            ),
            // Mute/Unmute button
            Positioned(
              top: 16.0,
              right: 16.0,
              child: IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
                onPressed: _toggleMute,
              ),
            ),
          ],
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    // Tap to place the model
    arkitController.onARTap = (ar) {
      final hitResult = ar.firstWhereOrNull(
        (result) => result.type == ARKitHitTestResultType.featurePoint,
      );

      if (hitResult != null) {
        _addOrUpdateNode(hitResult);
      }
    };

    // Automatically load the solar system model on initialization
    if (widget.planet.name.toLowerCase() == 'solar system') {
      _addInitialSolarSystemNode();
    }
  }

  void _addOrUpdateNode(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    // Remove the existing node, if any
    if (currentNode != null) {
      arkitController.remove(currentNode!.name);
    }

    // Add the new node at the tapped position
    currentNode = ARKitGltfNode(
      assetType: AssetType.flutterAsset,
      url: widget.planet.modelPath,
      position: position,
      scale: _getModelScale(widget.planet),
    );

    arkitController.add(currentNode!);
  }

  void _addInitialSolarSystemNode() {
    // This method adds the solar system model at a default position in front of the user
    final position = vector.Vector3(0, -0.5, -1.0); // Adjust position as needed
    currentNode = ARKitGltfNode(
      assetType: AssetType.flutterAsset,
      url: widget.planet.modelPath,
      position: position,
      scale: _getModelScale(widget.planet),
    );

    arkitController.add(currentNode!);
  }

  vector.Vector3 _getModelScale(Planet planet) {
    // Adjust scale based on the model type
    if (planet.name.toLowerCase() == 'solar system') {
      return vector.Vector3(0.05, 0.05, 0.05);
    }
    if (planet.name.toLowerCase() == 'sun') {
      return vector.Vector3(0.01, 0.01, 0.01);
    }
    return vector.Vector3(0.001, 0.001, 0.001); // Smaller scale for individual planets
  }
}
