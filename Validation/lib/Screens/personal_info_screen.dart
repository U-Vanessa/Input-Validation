import 'package:flutter/material.dart';
import 'contact_info_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    final age = int.tryParse(value);
    if (age == null || age < 18 || age > 120) {
      return 'Age must be between 18 and 120';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    if (value.length < 10) {
      return 'Address must be at least 10 characters long';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactInfoScreen(
            name: _nameController.text,
            age: _ageController.text,
            address: _addressController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Personal Information',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Container(
        color: Colors.green[50],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Enter Your Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildTextField(_nameController, 'Full Name',
                    'Enter your full name', Icons.person, _validateName),
                const SizedBox(height: 16),
                _buildTextField(_ageController, 'Age', 'Enter your age',
                    Icons.calendar_today, _validateAge,
                    isNumber: true),
                const SizedBox(height: 16),
                _buildTextField(_addressController, 'Address',
                    'Enter your full address', Icons.home, _validateAddress,
                    maxLines: 3),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String hint, IconData icon, String? Function(String?)? validator,
      {bool isNumber = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: validator,
      maxLines: maxLines,
    );
  }
}
