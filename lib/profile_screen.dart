import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'athlete_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final athleteData = Provider.of<AthleteData>(context);
    _weightController = TextEditingController(text: athleteData.weight.toString());
    _heightController = TextEditingController(text: athleteData.height.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final athleteData = Provider.of<AthleteData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: GoogleFonts.poppins()),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildProfileItem('Full Name', athleteData.fullName),
              _buildProfileItem('Age', athleteData.age.toString()),
              _buildProfileItem('Gender', athleteData.gender),
              _buildProfileItem('City', athleteData.city),
              _buildProfileItem('State', athleteData.state),
              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                   if (_formKey.currentState!.validate()) {
                      final newWeight = double.parse(_weightController.text);
                      final newHeight = double.parse(_heightController.text);
                      Provider.of<AthleteData>(context, listen: false).updateWeightAndHeight(newWeight, newHeight);
                      log('New Weight: $newWeight, New Height: $newHeight');
                   }
                },
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                   log('Upload Sports Certificates button pressed');
                },
                child: const Text('Upload Sports Certificates'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}