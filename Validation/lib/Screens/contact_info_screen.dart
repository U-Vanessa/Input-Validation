import 'package:flutter/material.dart';

class ContactInfoScreen extends StatefulWidget {
  final String name;
  final String age;
  final String address;

  const ContactInfoScreen({
    super.key,
    required this.name,
    required this.age,
    required this.address,
  });

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyContactController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value, {bool isEmergency = false}) {
    if (value == null || value.isEmpty) {
      return isEmergency
          ? 'Enter emergency contact number'
          : 'Enter your phone number';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit number';
    }
    if (isEmergency && value == _phoneController.text) {
      return 'Emergency contact must be different from your number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Registration Successful',
            style: TextStyle(
              color: Color(0xFF00695C),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Thank you ${widget.name} for registering!\n\n'
            'We will contact you at ${_emailController.text} '
            'or ${_phoneController.text}.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context)
                ..pop()
                ..pop(),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF004D40),
              ),
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF00897B),
        elevation: 0,
        title: const Text(
          'Contact Information',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF00897B).withOpacity(0.1),
              Colors.grey[50]!
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Contact Details',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00796B)),
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email address',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: 'Enter your 10-digit phone number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) => _validatePhone(value),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _emergencyContactController,
                  label: 'Emergency Contact',
                  hint: 'Enter emergency contact number',
                  icon: Icons.contact_phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      _validatePhone(value, isEmergency: true),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF00796B)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00796B), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: TextInputAction.next,
    );
  }
}
