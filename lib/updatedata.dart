import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CultureFirestoreExample extends StatefulWidget {
  const CultureFirestoreExample({Key? key}) : super(key: key);

  @override
  _CultureFirestoreExampleState createState() =>
      _CultureFirestoreExampleState();
}

class _CultureFirestoreExampleState extends State<CultureFirestoreExample> {
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _historyController = TextEditingController();
  final _isHotController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _featureControllers = List.generate(4, (_) => TextEditingController());
  final _imageControllers = List.generate(4, (_) => TextEditingController());

  Future<void> saveCultureToFirestore() async {
    try {
      // Construct the data to save
      final cultureData = {
        'title': _titleController.text.trim(),
        'address': _addressController.text.trim(),
        'description': _descriptionController.text.trim(),
        'history': _historyController.text.trim(),
        'feature': _featureControllers.map((controller) => controller.text.trim()).toList(),
        'image': _imageControllers.map((controller) => controller.text.trim()).toList(),
        'isHot': int.tryParse(_isHotController.text.trim()) ?? 0,
        'location': GeoPoint(
          double.tryParse(_latitudeController.text.trim()) ?? 0.0,
          double.tryParse(_longitudeController.text.trim()) ?? 0.0,
        ),
      };

      // Save to Firestore
      await FirebaseFirestore.instance.collection('Culture').add(cultureData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Culture document added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _historyController.dispose();
    _isHotController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    for (var controller in _featureControllers) {
      controller.dispose();
    }
    for (var controller in _imageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Culture to Firestore'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(controller: _titleController, labelText: 'Title'),
            _buildTextField(controller: _addressController, labelText: 'Address'),
            _buildTextField(
                controller: _descriptionController, labelText: 'Description'),
            _buildTextField(controller: _historyController, labelText: 'History'),
            _buildTextField(
                controller: _isHotController, labelText: 'Is Hot (int)'),
            const SizedBox(height: 16),
            const Text('Features:'),
            ..._featureControllers
                .asMap()
                .entries
                .map((entry) => _buildTextField(
                      controller: entry.value,
                      labelText: 'Feature ${entry.key + 1}',
                    )),
            const SizedBox(height: 16),
            const Text('Images:'),
            ..._imageControllers
                .asMap()
                .entries
                .map((entry) => _buildTextField(
                      controller: entry.value,
                      labelText: 'Image ${entry.key + 1} URL',
                    )),
            const SizedBox(height: 16),
            const Text('Location:'),
            _buildTextField(
                controller: _latitudeController, labelText: 'Latitude'),
            _buildTextField(
                controller: _longitudeController, labelText: 'Longitude'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveCultureToFirestore,
              child: const Text('Save Culture'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String labelText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
